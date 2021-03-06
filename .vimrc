""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Most of this is based on Gary Bernhardt's .vimrc file:
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" vim: set ts=2 sts=2 sw=2 expandtab:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enter vim mode
set nocompatible

" set up Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" list of plugins installed by Vundle
Plugin 'gmarik/Vundle.vim'
Plugin 'docker/docker', {'rtp': '/contrib/syntax/vim/'}
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'Jimdo/vim-spec-runner'
Plugin 'mileszs/ack.vim'
Plugin 'ngmy/vim-rubocop'
Plugin 'reedes/vim-wordy'
Plugin 'rodjek/vim-puppet'
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
" stop system vim from segfaulting
if v:version >= 704
  Plugin 'wincent/Command-T'
end

" end of Vundle setup
call vundle#end()
filetype plugin indent on

set encoding=utf-8
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and searches
set history=10000
" always show status line
set laststatus=2
" custom status line
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
" height of command line
set cmdheight=2
" jump to the first open window that contains the specified buffer
set switchbuf=useopen
" show line numbers
set number
" minimal number of columns to use for the line number
set numberwidth=5
" always show tab page labels
set showtabline=2
" minimal number of columns for current window
set winwidth=79
" prevent vim from clobbering the scrollback buffer
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=5
" store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" enable syntax highlighting
syntax on
" use emacs-style tab completion when selecting files etc.
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
" better list strings
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
" yank and paste with the system clipboard
set clipboard=unnamed
" tweak keyword detection for search & completion
let g:sh_noisk=1
set iskeyword+=-
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces
" do not wrap lines
set nowrap
" auto-reload files on changes
set autoread
" never use tabs
set expandtab
" use 4 spaces
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set leader key to comma
let mapleader=","

" open files in directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
nmap <leader>e :edit %%
nmap <leader>v :view %%

" toggle files
nnoremap <leader><leader> <c-^>

" toggle folds
nnoremap <space> za

" spell-check current file
nnoremap <leader>S :!aspell --check --dont-backup '%'<cr>

" re-hardwrap paragraphs of text
nnoremap <leader>q gwip

" create markdown h1 and h2 headings
nnoremap <leader>1 yypVr=
nnoremap <leader>2 yypVr-

" open current file with Marked app
nnoremap <leader>m :!marked '%'<cr><cr>

" save file with sudo
cmap w!! '%'!sudo tee > /dev/null '%'

" rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
nnoremap <leader>n :call RenameFile()<cr>

" promote variable to rspec let
function! PromoteToLet()
  normal! dd
  normal! P
  .s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  normal ==
endfunction
command! PromoteToLet :call PromoteToLet()
nnoremap <leader>p :PromoteToLet<cr>

" insert hash rocket with ctrl+l
imap <c-l> <space>=><space>

" disable arrow keys
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

" move by screen line
nnoremap j gj
nnoremap k gk

" open new vertical/horizontal split and switch over to it
nnoremap <leader>w <c-w>v<c-w>l
nnoremap <leader>W <c-w>s<c-w>j

" move around splits more easily
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" remove smart quotes, etc.
function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCHING & MOVING
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :nohlsearch<cr>
nnoremap <tab> %
vnoremap <tab> %

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMAND-T PLUGIN
" https://wincent.com/blog/tweaking-command-t-and-vim-for-use-in-the-terminal-and-tmux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ttimeoutlen=50

if &term =~ "xterm" || &term =~ "screen"
  let g:CommandTCancelMap     = ['<ESC>', '<C-c>']
  let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<ESC>OB']
  let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<ESC>OA']
endif

nmap <leader>f :CommandTFlush<cr>\|:CommandT<cr>
nmap <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>
nmap <leader>b :CommandTBuffer<cr>

let g:CommandTMaxHeight = 20
let g:CommandTAlwaysShowDotFiles = 1
let g:CommandTWildIgnore = &wildignore . ",vendor/**,**/node_modules/**"
let g:CommandTTraverseSCM = "pwd"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUBOCOP PLUGIN
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vimrubocop_extra_args = "-D"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUGITIVE PLUGIN AND OTHER GIT STUFF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>c :Gcommit --verbose '%'<cr>
nnoremap <leader>C :Gcommit --verbose --all<cr>

nnoremap <leader>d :!git diff '%'<cr>
nnoremap <leader>D :!git diff<cr>

" open a split for each dirty file in git
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "vsp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-GO PLUGIN
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:go_fmt_command = "goimports"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-PUPPET PLUGIN
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:puppet_align_hashes = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup vimrcEx
  " clear all autocmds in this group
  autocmd!

  " jump to last cursor position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " detect present files
  autocmd BufNewFile,BufRead *.slide set filetype=present

  " language-dependent indenting
  autocmd FileType text,markdown,present setlocal ts=4 sw=4 et si tw=80
  autocmd FileType sh,perl,awk,python,dockerfile setlocal ts=4 sw=4 et si
  autocmd FileType ruby,cucumber,yaml,vim setlocal ts=2 sw=2 et si
  autocmd FileType c,h,cpp setlocal ts=8 sw=8 noet cindent
  autocmd FileType make setlocal ts=8 sw=8 noet
  autocmd FileType asm setlocal ts=8 sw=8 noet

  " auto-complete file names when committing
  autocmd FileType gitcommit setlocal iskeyword+=.

  " speed up Ruby syntax highlighting
  autocmd FileType ruby setlocal re=1 nocursorline

  " auto-complete Ruby names up to ! and ?
  autocmd FileType ruby setlocal iskeyword+=!,?

  " run Go tests
  autocmd FileType go nnoremap <leader>t :w\|:!./script/test %<cr>
  autocmd FileType go nnoremap <leader>T :w\|:GoTestFunc<cr>

  " run Rust tests
  autocmd FileType rust nnoremap <leader>t :w\|:RustRun! --test<cr>

  " enable spell-checking
  autocmd FileType text,markdown,gitcommit,present setlocal spell spelllang=en_us
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ADD LOCAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if filereadable(expand("$HOME/.vimrc.local"))
  source $HOME/.vimrc.local
endif
