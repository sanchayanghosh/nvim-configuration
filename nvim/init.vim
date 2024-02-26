set clipboard=unnamed

lua require('plugins')

language en_US

set "let g:deoplete#enable_at_startup = 1"

set "let g:jedi#completions_enabled = 0"
set "let g:jedi#use_splits_not_buffers = \"right\""
set "let g:neomake_python_enabled_makers = ['pylint']"
hi HighlightedyankRegion cterm=reverse gui=reverse
set "let g:highlightedyank_highlight_duration = 2000"
nnoremap nd :NERDTree<CR>
nnoremap dn :NERDTreeClose<CR>
nnoremap mt :Magit<CR>

nnoremap <Leader>o :lua require('dap').step_over()<CR>
nnoremap <Leader>i :lua require('dap').step_into()<CR>

nnoremap <Leader>a :lua require('dap').continue()<CR>
nnoremap <Leader>O :lua require('dap').step_out()<CR>
nnoremap <Leader>B :lua require('dap').toggle_breakpoint()<CR>
nnoremap <Leader>b :lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR> 
nnoremap <Leader>r :lua require('dap').repl.open()<CR>
nnoremap <Leader>l :lua require('dap').run_last()<CR>	

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
