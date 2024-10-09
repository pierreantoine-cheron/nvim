vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.ixx",
  callback = function()
    vim.filetype.add({
      extension = {
        ixx = "cpp"
      }
    })
  end
})
