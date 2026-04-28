#!/usr/bin/env bash
set -euo pipefail

# If this file has already been replaced by the real binary, it won't be a bash script anymore,
# so we only ever reach here on the first run (or if someone reinstalled the wrapper).

arch="$(uname -m)"
case "$arch" in
  x86_64|amd64) asset="difft-x86_64-unknown-linux-gnu.tar.gz" ;;
  aarch64|arm64) asset="difft-aarch64-unknown-linux-gnu.tar.gz" ;;
  *)
    echo "difftastic bootstrap: unsupported architecture: $arch" >&2
    exit 1
    ;;
esac

if ! command -v curl >/dev/null 2>&1; then
  echo "difftastic bootstrap: curl is required (apt-get install -y curl)" >&2
  exit 1
fi
if ! command -v tar >/dev/null 2>&1; then
  echo "difftastic bootstrap: tar is required (apt-get install -y tar)" >&2
  exit 1
fi

target="${DIFFTASTIC_BIN:-/usr/local/bin/difftastic}"

tmpdir="$(mktemp -d)"
cleanup() { rm -rf "$tmpdir"; }
trap cleanup EXIT

curl -fsSL "https://github.com/Wilfred/difftastic/releases/latest/download/$asset" -o "$tmpdir/difft.tar.gz"
tar -xzf "$tmpdir/difft.tar.gz" -C "$tmpdir"

# The tarball contains a directory like difft-<version>-*/difft
binpath="$(find "$tmpdir" -type f -name difft -perm -u+x | head -n 1)"
if [[ -z "${binpath:-}" ]]; then
  echo "difftastic bootstrap: failed to find extracted 'difft' binary" >&2
  exit 1
fi

# Replace this wrapper with the real binary, renamed to `difftastic`
# Use sudo only if needed.
if [[ -w "$(dirname "$target")" ]]; then
  install -m 0755 "$binpath" "$target"
else
  sudo install -m 0755 "$binpath" "$target"
fi

# Now run the real binary with the original args
exec "$target" "$@"