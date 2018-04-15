nnoremap <leader>ts :Obsess!<cr>

" Loads a session if it exists
if (filereadable("Session.vim"))
    exe 'silent source Session.vim'
endif
