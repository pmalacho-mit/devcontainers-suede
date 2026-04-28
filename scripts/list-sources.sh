#!/usr/bin/env bash
set -euo pipefail

# USAGE: list-sources.sh <file.json>
#
# Recursively lists all files that are `extended` by the given JSON file,
# Prints each file (one per line), in merge order, relative to the file.json's directory.
# Includes the file itself at the end (so processing a file with no extends will simply output its own name).

src="$1"
base_dir="$(dirname "$src")"
declare -A seen

relpath() {
  realpath --relative-to="$base_dir" "$1"
}

# Recursively walk extends[] and then emit this file
process() {
  local f="$1"
  # canonicalize
  f="$(realpath "$f")"
  # if f is a directory, iterate through its .json files
  if [[ -d "$f" ]]; then
    for jf in "$f"/*.json; do
      # skip if no .json files found
      [[ -e "$jf" ]] && process "$jf"
    done
    return
  fi
  # produce a relative key for dedupe
  local rel="$(realpath --relative-to="$base_dir" "$f")"
  [[ -n "${seen[$rel]:-}" ]] && return
  seen[$rel]=1

  # read its extends array (if any)
  mapfile -t exts < <(jq -r '.extends[]? // empty' "$f")
  for e in "${exts[@]}"; do
    # resolve e relative to this file's dir
    if [[ "$e" = /* ]]; then
      next="$e"
    else
      next="$(dirname "$f")/$e"
    fi
    process "$next"
  done

  # now emit this file (after its bases)
  echo "$rel"
}

process "$src"