if vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
  vim.opt.ff = 'dos'

  vim.g.SLASH = '\\'

  vim.opt.shell = 'powershell'

  vim.opt.shellcmdflag = '-command'
  vim.opt.shellquote = '"'
  vim.opt.shellxquote = ''
end

if vim.fn.has("unix") == 1 then
  vim.opt.ff = 'unix'

  vim.g.SLASH = '/'

  vim.cmd([[
    let s:clip = '/mnt/c/Windows/System32/clip.exe'
    if executable(s:clip)
      augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
      augroup END
    endif
  ]])
end

vim.env.VIMHOME = table.concat({ vim.env.HOME, '.nvim' }, vim.g.SLASH)

vim.cmd [[
  let s:after = $VIMHOME . g:SLASH . 'after'
  set runtimepath^=$VIMHOME runtimepath+=s:after
  let &packpath=&runtimepath
]]

vim.g.VIMUNDODIR = table.concat({ vim.env.VIMHOME, 'vimundo' }, vim.g.SLASH)

if vim.fn.isdirectory(vim.env.VIMHOME) ~= 1 then
  vim.fn.mkdir(vim.env.VIMHOME, "p")
end

if vim.fn.isdirectory(vim.g.VIMUNDODIR) ~= 1 then
  vim.fn.mkdir(vim.g.VIMUNDODIR, "p")
end

require('settings')
require('mappings')
require('augroups')
require('sessions')
require('lspconfigs')
require('plugins')
require('configs')
