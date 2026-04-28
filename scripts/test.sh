#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
errors_file="$(mktemp)"
trap 'rm -f "$errors_file"' EXIT

# Find all folders in the same directory containing '.tests.'
find "$script_dir" -mindepth 1 -maxdepth 1 -type d -name '*.tests' | while read -r tests_dir; do
  # Recursively find all run.sh files within those folders
  find "$tests_dir" -type f -name 'run.sh' | while read -r run_file; do
    rel_path="${run_file#$script_dir/}"
    echo "Running: $rel_path"
    if ! bash "$run_file"; then
      err_msg="Error in $rel_path"
      echo "$err_msg"
      echo "$rel_path" >> "$errors_file"
    fi
  done
done

mapfile -t errors < "$errors_file"

if (( ${#errors[@]} > 0 )); then
  echo "Some tests failed:"
  for err in "${errors[@]}"; do
    echo "  $err"
  done
  exit 1
fi