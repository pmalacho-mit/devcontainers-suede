#!/bin/bash
# Install the real opencode
echo 'Installing opencode on first use...'

# Delete this wrapper script - the real opencode is now installed
sudo rm -f /usr/local/bin/opencode

curl -fsSL https://opencode.ai/install | bash && sudo chown -R vscode:vscode /home/vscode/.local
