"===========================================================
"======================= coc configs =======================
"===========================================================


let g:coc_data_home = $VIMHOME . g:SLASH . "coc"
let g:coc_config_home = $VIMHOME

let g:coc_global_extensions = [
      \ 'coc-db',
      \ 'coc-omnisharp',
      \ 'coc-powershell',
      \ 'coc-cmake',
      \ 'coc-emmet',
      \ 'coc-highlight',
      \ 'coc-sh',
      \ 'coc-vimlsp',
      \ 'coc-syntax',
      \ 'coc-diagnostic',
      \ 'coc-explorer',
      \ 'coc-gitignore',
      \ 'coc-css',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-prettier',
      \ 'coc-pyright',
      \ 'coc-snippets',
      \ 'coc-sourcekit',
      \ 'coc-stylelint',
      \ 'coc-xml',
      \ 'coc-rls',
      \ 'coc-java',
      \ 'coc-java-lombok',
      \ 'coc-phpls',
      \ 'coc-tslint-plugin',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ 'coc-lua',
      \ 'coc-webview',
      \ 'coc-markdown-preview-enhanced',
      \ 'coc-elixir',
      \ 'coc-yank']


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use gm to show documentation in preview window.
nnoremap <silent> gm :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('gm', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for apply code actions at the cursor position.
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer.
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for apply refactor code actions.
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

function configs_shared#Format()
  if CocHasProvider('format')
    call CocActionAsync('format')
  else
    let v = winsaveview()
    norm! gg=G
    call winrestview(v)
  endif
endfunction

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call configs_shared#Format()
nnoremap <silent> <A-f> :Format<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
nnoremap <silent> <A-o> :OR<CR>

" Disable diagnostics for current buffer
command! -nargs=0 DiagnosticToggle   :call     CocActionAsync('diagnosticToggle')
nnoremap <silent> td :DiagnosticToggle<CR>

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"===========================================================
"======================= templates =========================
"===========================================================

let g:templates_directory=[$VIMHOME . g:SLASH . "templates"]


"==============================================================
"======================= fzf-vim ==============================
"==============================================================

command! ProjectFiles execute 'Files' helpers#FindGitRoot()

let $FZF_DEFAULT_COMMAND = (executable('fdfind') ? 'fdfind' : 'fd') . ' -HI -E ".git" -E ".hg" -E ".svn" -E "node_modules" -E "DS_Store" -E "target" -E "dist" -E "obj" -E "build"'

nnoremap <silent><nowait> <C-p> :ProjectFiles<CR>
nnoremap <silent><nowait> <C-g> :GFiles<CR>
nnoremap <silent><nowait> <C-l> :Buffers<CR>
nnoremap <silent><nowait> <A-S> :Rg<CR>

let g:fzf_layout = { 'down': '30%' }
let g:fzf_preview_window = ['right,50%', 'ctrl-/']

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'  }


"==============================================================
"======================= fugitive =============================
"==============================================================

nnoremap <silent>cm :tabedit % \| Gvdiffsplit!<CR>
nnoremap <silent>co :diffget //2<CR>
nnoremap <silent>ct :diffget //3<CR>
nnoremap <silent>cb :call helpers#GacceptBoth()<CR>
nnoremap <silent>cs :only<CR>
nnoremap <silent>cu :diffupdate<CR>

"==============================================================
"======================= auto-pairs ===========================
"==============================================================

let g:AutoPairsShortcutToggle = ''


"==============================================================
"======================= context ==============================
"==============================================================

let g:context_add_mappings = 0
