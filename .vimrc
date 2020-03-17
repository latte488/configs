
set fenc=utf-8
set encoding=utf-8
set number
set autoread
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

let g:ale_lint_on_text_changed = 'always'

let g:python3_host_prog = '/opt/conda/bin/python'

let g:ale_linters = {
    \ 'python': ['flake8'],
    \ }

let g:ale_python_flake8_executable = g:python3_host_prog
let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_autopep8_executable = g:python3_host_prog
let g:ale_python_autopep8_options = '-m autopep8'

augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END 

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1) 
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

