# Pierre-Antoine Chéron's Neovim configuration

These are my neovim dotfiles.
This configuration is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), that I splitted into multiple files.

### Getting Started

If you are new to neovim, I highly recommend [this video](https://youtu.be/m8C0Cq9Uv9o)

### Windows Installation

Installation may require installing build tools, and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake, and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```

### To do:

Change mapping so hjkl are used only for movement related things. ex <C-k> should allow to nav up in list not hover definition
add ai completions: jackmort/chatgpt.nvim (with local llm in Ollama ?) or zbirenbaum/copilot.lua
