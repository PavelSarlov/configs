vim.opt.sessionoptions = 'curdir,help,tabpages'

vim.g.SESSIONLOC = table.concat({ vim.env.VIMHOME, 'sessions' }, vim.g.SLASH)

vim.fn['helpers#CreateDirRecursive'](vim.g.SESSIONLOC)

function MakeSession()
  local session_path = table.concat({ vim.g.SESSIONLOC, vim.fn.sha256(vim.fn.getcwd()) .. '.vim' }, vim.g.SLASH)
  if (vim.fn.filewritable(session_path) ~= 2) then
    vim.cmd('mksession! ' .. session_path)
    vim.cmd 'redraw!'
  end
end

function LoadSession()
  local session_path = table.concat({ vim.g.SESSIONLOC, vim.fn.sha256(vim.fn.getcwd()) .. '.vim' }, vim.g.SLASH)
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

return {
  make_session = MakeSession,
  load_session = LoadSession,
}
