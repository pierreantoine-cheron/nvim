vim.defer_fn(function ()
  vim.filetype.add({
    extension = {
      ixx = "cpp"
    }
  })
end, 10)
