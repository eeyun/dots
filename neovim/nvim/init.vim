"" ~/.vimrc
"

" Vundle
"---------------------------------
set nocompatible              " be iMproved, required
set encoding=utf-8
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/plugged')

    Plug 'https://github.com/tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'LaTeX-Box-Team/LaTeX-Box'

    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug 'Shougo/deoppet.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug 'Shougo/denite.nvim',
        Plug 'zchee/deoplete-go', { 'do': 'make' }
    else
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif

    Plug 'artur-shaik/vim-javacomplete2'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'vim-scripts/cSyntaxAfter'
    Plug 'dylanaraps/wal.vim'
    Plug 'sukima/xmledit'
    Plug 'junegunn/goyo.vim'
    Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' } " Go auto completion

    Plug 'christoomey/vim-tmux-navigator'
    Plug 'rust-lang/rust.vim'
    Plug 'racer-rust/vim-racer'
    Plug 'fatih/vim-go'
    Plug 'ohjames/colemak'
    Plug 'uarun/vim-protobuf'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'sheerun/vim-polyglot'
    Plug 'Shougo/unite.vim'
    Plug 'Shougo/vimfiler.vim'
    Plug 'ryanoasis/vim-devicons'
    " Generic Language Server Protocol (LSP) support
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'w0rp/ale'
    Plug 'chrisbra/Colorizer'

call plug#end()
filetype plugin indent on

" General Options
"---------------------------------
colorscheme agila

syntax on
set number relativenumber
set ruler
"!set showmode
set showcmd

" cut long messages
set shm=atI

" set textwidth=80
set textwidth=0 wrapmargin=0

" don't wrap long lines
"set nowrap

set splitbelow
set splitright

" ignore case when searching
set smartcase
set ignorecase

" persistant undo
if has('persistant_undo') && !isdirectory(expand('~').'/.config/nvim/backups')
    silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
    set undodir=~/.config/nvim/backups
    set undofile
end

" set persistant undo
set undofile

" set undo dir
set undodir=$HOME/.config/nvim/undo

" save 1000 undos
set undolevels=1000

set directory=~/.config/nvim/swap,~/tmp,.      " keep swp files under ~/.vim/swap

" Indenting
"---------------------------------
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab


" Status
"---------------------------------
set laststatus=2
let g:currentmode={
    \ 'n'  : 'normal ',
    \ 'no' : 'n·operator pending ',
    \ 'v'  : 'visual ',
    \ 'V'  : 'v·line ',
    \ '' : 'v·block ',
    \ 's'  : 'select ',
    \ 'S'  : 's·line ',
    \ '' : 's·block ',
    \ 'i'  : 'insert ',
    \ 'R'  : 'replace ',
    \ 'Rv' : 'v·replace ',
    \ 'c'  : 'command ',
    \ 'cv' : 'vim ex ',
    \ 'ce' : 'ex ',
    \ 'r'  : 'prompt ',
    \ 'rm' : 'more ',
    \ 'r?' : 'confirm ',
    \ '!'  : 'shell ',
    \ 't'  : 'terminal '}

set statusline=
set statusline+=%#PrimaryBlock#
set statusline+=\ %{g:currentmode[mode()]}
set statusline+=%#SecondaryBlock#
set statusline+=%{StatuslineGit()}
set statusline+=%#TeritaryBlock#
set statusline+=\ %f\
set statusline+=%M\
set statusline+=%#TeritaryBlock#
set statusline+=%=
set statusline+=%#SecondaryBlock#
set statusline+=\ %Y\
set statusline+=%#PrimaryBlock#
set statusline+=\ %P\

function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

hi def Dim cterm=none ctermbg=none ctermfg=14

function! s:DimInactiveWindow()
    syntax region Dim start='' end='$$$end$$$'
endfunction

function! s:UndimActiveWindow()
    ownsyntax
endfunction

autocmd WinEnter * call s:UndimActiveWindow()
autocmd BufEnter * call s:UndimActiveWindow()
autocmd WinLeave * call s:DimInactiveWindow()

" Syntax highlighting
"---------------------------------
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
noremap <Leader>c :set cursorcolumn! <CR>

set colorcolumn=81
hi colorcolumn ctermfg=14

set fillchars+=vert:│

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Keybinds
"---------------------------------
let mapleader = ","
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

map e <Up>
map n <Down>
map i <Right>

noremap k n
noremap K N
noremap u i
noremap U I
noremap l u
noremap L U
noremap N J
noremap E K
noremap I L

noremap j e
noremap J E

nnoremap <c-w>n <c-w>j
nnoremap <c-w>i <c-w>l
nnoremap <c-w>e <c-w>k

" Code Folding
"---------------------------------
if has ('folding')
    set nofoldenable
    set foldmethod=syntax
    set foldmarker={{{,}}}
    set foldcolumn=0
endif

function RangerExplorer()
    exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
    if filereadable('/tmp/vim_ranger_current_file')
        exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
        call system('rm /tmp/vim_ranger_current_file')
    endif
    redraw!
endfun
map <Leader>x :call RangerExplorer()<CR>


" deoplete & neosnippet
"---------------------------------
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.config/nvim/bundle/vim-snippets/snippets'

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" javacomplete
"---------------------------------
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Devicons
"---------------------------------
" Add or override individual additional filetypes
if !exists('g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols')
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
endif
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {'tex': '',
            \ 'bib':'', 'gitcommit': ''}

" Add or override individual specific files
if !exists('g:WebDevIconsUnicodeDecorateFileNodesExactSymbols')
    let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
endif
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {'.gitconfig': '',
            \ '.gitignore': '', 'bashrc': '', '.bashrc': '',
            \ 'bash_profile': '', '.bash_profile': ''}

" Disable denite integration (because it makes denite really slow)
let g:webdevicons_enable_denite = 0
" delimitMate
"---------------------------------
let delimitMate_expand_cr = 1

" ctrlp
"---------------------------------
" Use <leader>t to open ctrlp
"let g:ctrlp_map = '<leader>t'
" Ignore these directories
set wildignore+=*/build/**
" disable caching
let g:ctrlp_use_caching=0

" cSyntaxAfter
"---------------------------------
autocmd! FileType c,cpp,java,php call CSyntaxAfter()

" Airline
" --------------------------------
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" ColorThemes
" ------------------------------
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

  if (has("termguicolors"))
    set termguicolors
  endif
endif

" NERDTree
"--------------------------------

" ALE Config
"--------------------------------
" ALE linter configuration

" Map leader a to manually run ALE lint
map <leader>a :ALELint<CR>

" Disable all highlighting of warnings and errors
let g:ale_set_highlights = 0

" Disable all other automatic linting runs and rely on the manual linting
" exclusively instead
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_filtype_changed = 0

" Initialize the ALE fixers dictionary
let g:ale_fixers = {}

" If `shfmt` is present, register it as an ALE fixer, using Google-style
" formatting
if executable('shfmt')
  let g:ale_fixers['sh'] = ['shfmt']
  let g:ale_sh_shfmt_options = '-i 2 -ci'
endif

" asyncomplete config
" ----------------------------------

" `Tab` key press calls `Ctrl+n` only if the completion window is visible
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" `Shift+Tab` key press calls `Ctrl+n` only if the completion window is
" visible
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" `Retrun` key press calls `Ctrl+y` only if the completion window is visible
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Auto-close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

imap <C-space> <Plug>(asyncomplete_force_refresh)

" Language Server Protocol
" ----------------------------------
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \}
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"
"" Map `Ctrl+i` to hover
map <C-i> :call LanguageClient#textDocument_hover()<CR>
"" Map `g] to go to definition
nnoremap g] :call LanguageClient#textDocument_definition()<CR>



" close the tree window after opening a file
let g:NERDTreeQuitOnOpen = 1

" enable extended % matching for HTML, LaTeX, and many other languages
runtime macros/matchit.vim

" Ctrl-P ignores
let g:ctrlp_custom_ignore = '\v[\/](tmp|vendor/bundle|\.git)$'

" Ctrl-P sets its local working directory the directory of the current file
let g:ctrlp_working_path_mode = 'a'

" LaTeX - Box
"---------------------------------
let g:tex_flavor = "latex"
let g:tex_fast = "cmMprs"
let g:tex_conceal = ""
let g:tex_fold_enabled = 0
let g:tex_comment_nospell = 1
let g:LatexBox_quickfix = 2
let g:LatexBox_latexmk_preview_continuously = 1
let g:LatexBox_viewer = "mupdf"

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

function! TexEdit()
    set spelllang=en_us spell
    set modeline
    set colorcolumn=
    :Goyo 80%
    map <Leader>m :Latexmk<CR>
endfunction

source $HOME/.config/nvim/rust.vimrc

autocmd! FileType rust call FileTypeRust()

autocmd! FileType tex call TexEdit()

set tags=./tags;,tags;./.tags;,.tags;
silent! source "$HOME/.vim/bundle/vim-colemak/plugin/colemak.vim"

