vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.schedule(function()
      -- mason is lazy-loaded in NvChad, so load it before using its command
      require("lazy").load { plugins = { "mason.nvim" } }

      local spec = require("lazy.core.config").plugins["mason.nvim"]
      local wanted = spec and spec.opts and spec.opts.ensure_installed or {}
      local registry = require "mason-registry"

      local missing = false
      for _, name in ipairs(wanted) do
        local ok, installed = pcall(registry.is_installed, name)
        if not ok or not installed then
          missing = true
          break
        end
      end

      if missing then
        vim.cmd "MasonInstallAll"
      end
    end)
  end,
})
