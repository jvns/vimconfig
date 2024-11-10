"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Original source:
" https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim
" this basic.vim is super good -- not too complicated and has lots of sensible
" defaults
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=5

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Make vim regexps use verymagic (more like PCREs, write \w+ instead if \w\+)
nnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=light

" Set extra options when running in GUI mode
if has("gui_running")
    set guifont=Inconsolata\ Medium\ 14
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=0

set ai "Auto indent
set si "Smart indent
set nowrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.go,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => New tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickly open a buffer for scribble
"map <leader>t :tabnew<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => start of julia's custom stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" combine the system & vim clipboards
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
    set clipboard=unnamed
  else

    set clipboard=unnamedplus
  endif
endif
set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => persistent undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Make sure you use single quotes
Plug 'jremmen/vim-ripgrep' , {'commit': 'da940c29ac97dcb025696491c422b6d8545e3e10'}
Plug 'junegunn/fzf', { 'commit': 'e1582b8323a70785d7ebefce993df7474a28e749'}
Plug 'junegunn/fzf.vim', { 'commit': 'd3b9fed9c2415a2682cb1c8604e25a351325c22b'}
Plug 'chriskempson/base16-vim', { 'commit': '2d991f14f688a38b7b2bcd397bad5efadd0f80a9'}
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
Plug 'dense-analysis/ale' " formatting, linting, LSP
Plug 'norcalli/nvim-colorizer.lua'
Plug 'LnL7/vim-nix'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin: fzf & ripgrep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" map ctrl+p to fzf
map <C-p> :Files<cr>

" map ctrl shift p to fzf then open in new tab

nnoremap <C-S-P> :tabnew<CR>:Files<CR>

"""
"
"""

function! TakeScreenshot(name)
    " Take the screenshot
    call system('pngpaste static/images/' . a:name . '.png')
    
    " Insert the image tag at the current cursor position
    let l:img_tag = '<img src="/images/' . a:name . '.png">'
    execute "normal! i" . l:img_tag . "\<Esc>"
    
    echo "Screenshot saved and image tag inserted!"
endfunction

command! -nargs=1 Screenshot call TakeScreenshot(<q-args>)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => stuff about colours
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif


nmap <Leader>n :noh<CR>

hi statusline guibg=Purple ctermfg=0 guifg=White ctermbg=5

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

let g:vimwiki_list = [{
	\ 'path': '~/work/wiki',
	\ 'path_html': '~/work/wiki/public/',
    \ 'auto_diary_index': 1, 
	\ 'template_path': '~/work/wiki/templates/',
	\ 'template_default': 'julia',
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'custom_wiki2html': 'vimwiki_markdown',
	\ 'template_ext': '.tpl'}]
" make tab work in markdown files
let g:vimwiki_table_mappings = 0

let g:ale_fixers = {
 \ 'go': ['gofmt', 'goimports'],
 \ 'python': ['black'],
 \ 'rust': ['rustfmt'],
 \ 'javascript': ['prettier'],
 \ }
" \ 'javascript': ['deno'],
let g:ale_html_prettier_options = '--embedded-language-formatting=auto'
let g:ale_javascript_prettier_options = '--embedded-language-formatting=auto'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

let g:ale_linters_explicit = 1
" https://github.com/dense-analysis/ale/tree/master/ale_linters/python
let g:ale_linters = {
 \ 'go': ['gopls', 'staticcheck'],
 \ 'python': ['pyright'],
 \ 'javascript': ['deno'],
 \ 'rust': ['rls'],
 \ 'c': ['clangtidy'],
 \ 'sh': ['shellcheck'],
 \ }

map <leader>gd :ALEGoToDefinition<cr>

au BufNewFile,BufRead *.twee set filetype=twee 
" spellcheck
map <leader>s :setlocal spell spelllang=en<cr>

lang en_ca.UTF-8
let g:vimwiki_url_maxsave=0
" turn off concealing links
let g:vimwiki_conceallevel=0

let g:copilot_filetypes = {
\ 'markdown': v:false,
\ 'md': v:false,
\ }

set termguicolors

set diffopt+=iwhiteall
