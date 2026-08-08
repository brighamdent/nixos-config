require "nvchad.options"
vim.g.closetag_filenames = "*.html,*.xhtml,*.jsx,*.tsx"
vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx,*.tsx"
vim.g.closetag_filetypes = "html,js"
vim.g.closetag_xhtml_filetype = "xhtml,jsx,tsx"
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_regions = {
  ["typescript.tsx"] = "jsxRegion,tsxRegion",
  ["javascript.jsx"] = "jsxRegion",
}

vim.g.closetag_shortcut = ">"
-- vim.o.mouse = ""
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
vim.opt.textwidth = 80
vim.opt.rnu = true
vim.opt.conceallevel = 1
vim.api.nvim_command "highlight RainbowDelimiterPurple guifg=#B78AFF ctermfg=white"
vim.api.nvim_command "highlight RainbowDelimiterBlue guifg=#2aa4f5 ctermfg=white"
-- Enable filetype plugins
vim.cmd('filetype plugin on')

-- Automatically indent new lines if the previous lines were indented
vim.o.autoindent = true

-- Enable Markdown-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal formatoptions+=n"
})
if vim.g.neovide then
  -- vim.o.guifont = "JetbrainsMono Nerd Font:h10"

  vim.g.neovide_refresh_rate = 75

  -- vim.g.neovide_cursor_vfx_mode = "railgun"

  vim.keymap.set("i", "<c-s-v>", "<c-r>+")
  vim.keymap.set("i", "<c-r>", "<c-s-v>")
end
-- add yours here!
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
