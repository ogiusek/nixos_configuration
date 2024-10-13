local project_path = '/etc/nixos/applications/vim/lua';
package.path = project_path .. '/?.lua;' .. package.path

local lazy_path = project_path .. '/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazy_path
    })
end
vim.opt.rtp:prepend(lazy_path)

local lazy = require('lazy')

-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

lazy.setup({
    spec = {
        require('plugins.telescope'),
        -- require('')
        require('plugins.lsp'),
        -- require('plugins.tree'),
    }
})

-- require('plugins.config.telescope')
-- require('plugins.config.tree')

require('config.configuration')
