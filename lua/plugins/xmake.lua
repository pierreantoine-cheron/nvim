if vim.fn.executable('xmake') == 1 then
  return {
    "Mythos-404/xmake.nvim",
    lazy = true,
    event = "BufReadPost xmake.lua",
    opts = {
      on_save = {
        -- Configuration for generating `compile_commands.json`
        lsp_compile_commands = {
          enable = true,
          -- Directory name (relative path) for output file
          output_dir = "./",
        },
      },
    },
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  }
end

return {}
