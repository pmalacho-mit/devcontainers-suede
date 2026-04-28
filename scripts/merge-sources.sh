#!/usr/bin/env bash
set -euo pipefail

# USAGE: merge-sources.sh <file1.json> [file2.json ...] > merged.json
#
# Recursively collects all JSON files extended by each input file (using list-sources.sh),
# then merges their contents in order using a deep merge strategy via jq.
# The result is a single merged JSON object, with "extends" keys stripped from each input.
# Useful for combining layered configuration files that use "extends" inheritance.

self_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
list_script_file="$self_dir/list-sources.sh"

all_files=()
for src in "$@"; do
  mapfile -t files < <("$list_script_file" "$src")
  src_dir="$(cd "$(dirname "$src")" && pwd)"
  for f in "${files[@]}"; do
    if [[ "$f" = /* ]]; then
      all_files+=("$f")
    else
      all_files+=("$src_dir/$f")
    fi
  done
done

jq -s '
  def is_command_key: test("Command$");
  
  def deep_merge($val1; $val2; $key):
    [($val1, $val2) | type] as $types |
    if $types == ["object", "object"] then
        # merge objects
        reduce ([($val1, $val2) | keys[]] | unique[]) as $k ({};
            if all($val1, $val2; has($k)) then
                .[$k] = deep_merge($val1[$k]; $val2[$k]; $k)
            else
                .[$k] = ($val1[$k] // $val2[$k])
            end
        )
    elif $types == ["array", "array"] then
        # both arrays, concatenate
        $val1 + $val2
    elif ($key | is_command_key) and ($val1 != null) and ($val2 != null) then
        # special handling for command fields: convert to array or append to existing array
        if ($val1 | type) == "array" then
            $val1 + [$val2]
        elif ($val2 | type) == "array" then
            [$val1] + $val2
        else
            [$val1, $val2]
        end
    else
        # use default merge
        $val2 // $val1
    end
    ;

  # fold all inputs (base → … → child) through merge(), stripping any extends
  reduce .[] as $item (
    {};
    deep_merge(. ; $item | del(.extends); null)
  )
  |
  # Special handling for command fields: join arrays with &&
  # (applies to postCreateCommand, postStartCommand, postAttachCommand, etc.)
  reduce (keys[] | select(test("Command$"))) as $key (.;
    if (.[$key] | type) == "array" then
      .[$key] = (.[$key] | map(select(. != null and . != "")) | join(" && "))
    else
      .
    end
  )
' "${all_files[@]}"
