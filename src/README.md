# Full Configs (`devcontainer.*.json`)

Complete, composable devcontainer configurations that extend other files using the `extends` field.

## devcontainer.common.json

Base configuration shared by all devcontainers. Includes common features, customizations, mounts, and post-create commands.

[](./devcontainer.common.json)

## devcontainer.node-default.json

Node.js-focused devcontainer with common Node setup.

[](./devcontainer.node-default.json)

## devcontainer.python-default.json

Python-focused devcontainer with Python 3.12 and common Python tools.

[](./devcontainer.python-default.json)

## devcontainer.typescript-default.json

TypeScript/Node.js devcontainer with TypeScript compiler and Node.js 20.

[](./devcontainer.typescript-default.json)

## devcontainer.svelte-default.json

Svelte-focused devcontainer with Svelte customizations and Node.js 20.

[](./devcontainer.svelte-default.json)

## devcontainer.svelte-tailwind-default.json

Svelte with Tailwind CSS devcontainer, combining Svelte and Tailwind configurations.

[](./devcontainer.svelte-tailwind-default.json)

## devcontainer.poetry-default.json

Python devcontainer with Poetry dependency management.

[](./devcontainer.poetry-default.json)

## devcontainer.docker-outside-of-docker.json

Devcontainer configured to run Docker commands from within the container.

[](./devcontainer.docker-outside-of-docker.json)

# Customizations (`customization.*.json`)

VS Code editor customizations including settings, keybindings, and extensions.

## customization.format-on-save.json

Enables automatic code formatting when saving files.

[](./customization.format-on-save.json)

## customization.markdown.json

VS Code customizations specific to Markdown editing.

[](./customization.markdown.json)

## customization.mermaid.json

Extensions and settings for Mermaid diagram support in VS Code.

[](./customization.mermaid.json)

## customization.python.json

Python-specific VS Code customizations including linting and formatting tools.

[](./customization.python.json)

## customization.python-venv.json

Configures Python virtual environment detection and activation in VS Code.

[](./customization.python-venv.json)

## customization.svelte.json

Svelte language support and formatting customizations for VS Code.

[](./customization.svelte.json)

## customization.tab-size-2.json

Sets default editor tab size to 2 spaces.

[](./customization.tab-size-2.json)

## customization.tailwindcss.json

Tailwind CSS IntelliSense and linting for VS Code.

[](./customization.tailwindcss.json)

## customization.typescript.json

TypeScript-specific VS Code customizations including formatting and linting.

[](./customization.typescript.json)

# Features (`feature.*.json`)

Devcontainer Features that install tools and runtimes into the container.

## feature.git-subrepo.json

Installs git-subrepo for managing git subrepositories.

[](./feature.git-subrepo.json)

## feature.node-20.json

Installs Node.js 20.x runtime.

[](./feature.node-20.json)

## feature.poetry.json

Installs Poetry dependency manager for Python projects.

[](./feature.poetry.json)

## feature.postgres.json

Installs PostgreSQL database server.

[](./feature.postgres.json)

## feature.python-3.12.json

Installs Python 3.12 runtime.

[](./feature.python-3.12.json)

## feature.vim.json

Installs Vim editor.

[](./feature.vim.json)

# Images (`image.*.json`)

Base container images for devcontainers.

## image.ubuntu-24.json

Ubuntu 24.04 LTS base image.

[](./image.ubuntu-24.json)

# Mounts (`mount.*.json`)

Volume mounts that bind local directories into the container.

## mount.ssh.json

Mounts the local SSH config and keys into the container for Git operations and remote access.

> [!IMPORTANT]
> If you're using MacOS, ensure to also include [postCreateCommand.ignore-UseKeychain-in-ssh-config.json](#postcreatecommandignore-usekeychain-in-ssh-configjson) to avoid issues.

[](./mount.ssh.json)

# Post Create Commands (`postCreateCommand.*.json`)

Commands executed automatically after the devcontainer is created, used for setup and configuration.

## postCreateCommand.codeblockify.json

Installs the `codeblockify` utility for converting files into Markdown code blocks.

[](./postCreateCommand.codeblockify.json)

## postCreateCommand.containersync.json

Installs the `containersync` utility for syncing local devcontainer configs from the remote repository.

To update your `.devcontainer/devcontainer.json` to the latest version from `pmalacho-mit/devcontainers`, simply run the following in your devcontainer's terminal (at the root of your project):

```bash
containersync
```

[](./postCreateCommand.containersync.json)

## postCreateCommand.git-config-merge-divergent.json

Configures Git to use merge (instead of rebase) when pulling divergent branches.

[](./postCreateCommand.git-config-merge-divergent.json)

## postCreateCommand.git-config-vim-as-core-editor.json

Configures Vim as the default Git editor.

[](./postCreateCommand.git-config-vim-as-core-editor.json)

## postCreateCommand.ignore-UseKeychain-in-ssh-config.json

Adds `IgnoreUnknown UseKeychain` to SSH config for compatibility with non-macOS systems.

Used in tandem with [mount.ssh.json](#mountsshjson).

[](./postCreateCommand.ignore-UseKeychain-in-ssh-config.json) 
