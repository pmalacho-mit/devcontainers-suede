# USAGE: populate-devcontainers.sh
#
# Finds all devcontainer.*.json files in the src directory, merges each using merge-sources.sh,
# and writes the merged output to the release directory. This produces fully resolved
# devcontainer configuration files with "extends" inheritance applied.

self_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src_dir="$(realpath "$self_dir/../src")"
release_dir="$(realpath "$self_dir/../release")"
mkdir -p "$release_dir"

# Find all files in the src directory that end with .json and start with devcontainer.
mapfile -t files < <(find "$src_dir" -type f -name 'devcontainer.*.json' -print)

# loop through each file and execute merge-sources.sh
for file in "${files[@]}"; do
  base_name="$(basename "$file" .json)"
  merged_file="$release_dir/${base_name#devcontainer.}.json"
  "$self_dir/merge-sources.sh" "$file" > "$merged_file"
done