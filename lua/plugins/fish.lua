if vim.fn.executable('fish') == 1 then
    return { 'mtoohey31/cmp-fish' }
end
return {}