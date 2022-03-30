# nvim_lua_setup

## Layout

### `init.lua`

Contains preferences and theme setup as well as some useful autocommands tailored to the languages that I normally work with (Rust, OCaml) and imports the other lua files

### `lua/plugins.lua`

Uses [packer](https://github.com/wbthomason/packer.nvim) to install plugins

### `lua/lsp.lua`

Sets up language servers and mappings for code suggestions and completion

### `lua/completion.lua`

Sets up autocompletion sources with [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## Basic Setup

- Fork this repository (I make changes to this frequently, so do not treat this as a stable repository)
- Install [neovim](git@github.com:neovim/neovim.git) and locate the install directory. On Unix systems this should be at `~/.config/nvim`
- Install [lua](https://www.lua.org/download.html) and ensure the lua binary is in your system `$PATH`
- Clone this repository as follows `git clone https://github.com/W-A-James/nvim_lua_setup.git ~/.config/nvim`. This will replace your neovim configuration, so save those settings if you would like to return to them
- Install [packer](https://github.com/wbthomason/packer.nvim)
- Open `nvim` and run `:PackerInstall` to install plugins
- Refer to [nvim-lspconfig's language server configurations document](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) to install desired language servers
