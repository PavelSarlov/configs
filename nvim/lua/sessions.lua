vim.opt.sessionoptions = 'curdir,help,tabpages'

vim.g.SESSIONDIR = table.concat({ vim.env.VIMHOME, 'sessions' }, vim.g.SLASH)

if vim.fn.isdirectory(vim.g.SESSIONDIR) ~= 1 then
  vim.fn.mkdir(vim.g.SESSIONDIR, "p")
end

local function MakeSession()
  local session_path = table.concat({ vim.g.SESSIONDIR, vim.fn.sha256(vim.fn.getcwd()) .. '.vim' }, vim.g.SLASH)
  if (vim.fn.filewritable(session_path) ~= 2) then
    vim.fn.system('mkdir -p ' .. session_path)
    vim.cmd 'redraw!'
  end
  vim.cmd('mksession! ' .. session_path)
end

local function LoadSession()
  local session_path = table.concat({ vim.g.SESSIONDIR, vim.fn.sha256(vim.fn.getcwd()) .. '.vim' }, vim.g.SLASH)
  if (vim.fn.filereadable(session_path) == 1) then
    vim.cmd('source ' .. session_path)
  else
    print('No session loaded.')
  end
end

-- Adding automatons for when entering or leaving Vim
if (vim.fn.argc() == 0) then
  vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    pattern = '*',
    callback = LoadSession
  })
end
vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  pattern = '*',
  callback = function()
    MakeSession()
    vim.cmd('sleep 10m')
  end
})
