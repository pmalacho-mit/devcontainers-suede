#!/usr/bin/env bash
set -euo pipefail

self_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
test_script=$(realpath "$self_dir/../../merge-sources.sh")

cases=($(find "$self_dir" -mindepth 1 -maxdepth 1 -type d))

indent="  "

for test in "${cases[@]}"; do
  test_case=$(basename "$test")
  echo "$indent Running case: $test_case"
  test_files=("$test"/{a,b}.json)
  expected_file="$test/expected.json"
  if ! "$test_script" "${test_files[@]}" | diff --ignore-all-space - "$expected_file"; then
    echo "Test failed for case: $test_case. Output differs from expected." >&2
    exit 1
  fi
done