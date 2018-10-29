" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

augroup vimrc
  autocmd!
augroup END


" Disable default plugins
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
"let g:loaded_matchparen       = 1
let g:loaded_LogiPat           = 1
let g:loaded_logipat           = 1

" ~morishita/.vimrc から適当に抜粋

" http://www.crimson-snow.net/tips/unix/vim.html
" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

" ファイルタイプに応じた自動インデント
filetype plugin indent on

" オートインデントを無効にする
"set noautoindent
" タブが対応する空白の数
set tabstop=4
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=4
" インデントの各段階に使われる空白の数
set shiftwidth=4
" タブを挿入するとき、代わりに空白を使わない
" set noexpandtab
" タブを挿入するとき、代わりに空白を使う
set expandtab

"自動インデント
set autoindent 

" 行番号表示
set number
set relativenumber

" カーソル行を強調表示
" set cursorline

" カーソル行を強調表示sinai
set nocursorline

" 色,シンタックスハイライト設定
" set background=dark
" syntax on

highlight PreProc ctermfg=darkcyan

" コマンド補完設定
set wildmenu wildmode=full

" ステータスライン設定
set laststatus=2 "常に表示

set ignorecase

set smartcase

set incsearch

set hlsearch

" set clipboard=unnamedplus,autoselect
" for Mac
set clipboard=unnamed,autoselect
"
" ファイルを閉じてもundo履歴を保存
set undofile

set undodir=$HOME/.vim/undo

" 自動折り返し
set textwidth=80

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

" zsh like な補完に
set wildmode=longest,list:full

" tags 親ディレクトリを探しにいく
set tags=./tags;

"Bundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=$HOME/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('$HOME/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'mattn/benchvimrc-vim'
" NeoBundle 'davidhalter/jedi-vim'
" NeoBundle 'kevinw/pyflakes-vim'
"
" Markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'

""""""""""""""""""""""""""""""
"        neocomplete         "
""""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
inoremap <expr><CR>  pumvisible() ? neocomplete#close_popup() : "<CR>"
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
inoremap <expr><Space>  pumvisible() ? neocomplete#close_popup()."\<Space>" : "<Space>"
" inoremap <expr><Space>  pumvisible() ? neocomplete#close_popup() : "<Space>"
" inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
" let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" " docstringのポップアップを無効
autocmd FileType * setlocal completeopt-=preview
" " 補完をTabに
NeoBundle 'ervandew/supertab'
let g:SuperTabContextDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "<c-n>"

""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"         NERDTree           "
""""""""""""""""""""""""""""""
" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')

" easy-align
NeoBundle 'junegunn/vim-easy-align'

" sudo.vim
NeoBundle 'vim-scripts/sudo.vim'

" coffee-script syntax
NeoBundle 'kchmck/vim-coffee-script'
autocmd vimrc BufNewFile,BufRead *.coffee set filetype=coffee

au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Firefox'

"Djangoを正しくVimで読み込めるようにする
"追記:なんかこれをONにすると、vimがくっそ遅くなるんやが worte at 2016/09/01
" NeoBundleLazy "lambdalisue/vim-django-support", {
"       \ "autoload": {
"       \   "filetypes": ["python", "python3", "djangohtml"]
"       \ }}
" Vimで正しくvirtualenvを処理できるようにする
NeoBundleLazy "jmcantrell/vim-virtualenv", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}

NeoBundle "ujtak/vim-verb"
autocmd vimrc BufNewFile,BufRead *.v.erb  set filetype=verb
autocmd vimrc BufNewFile,BufRead *.vh.erb set filetype=verb

""""""""""""""""""""""""""""""
"          jedi-vim          "
""""""""""""""""""""""""""""""
" pythonの補完
" NeoBundleLazy "davidhalter/jedi-vim", {
"       \ "autoload": {
"       \   "filetypes": ["python", "python3", "djangohtml"],
"       \ },
"       \ "build": {
"       \   "mac": "pip install jedi",
"       \   "unix": "pip install jedi",
"       \ }}
" let s:hooks = neobundle#get_hooks("jedi-vim")
" function! s:hooks.on_source(bundle)
"   " jediにvimの設定を任せると'completeopt+=preview'するので
"   " 自動設定機能をOFFにし手動で設定を行う
"   let g:jedi#auto_vim_configuration = 0
"   " 補完の最初の項目が選択された状態だと使いにくいためオフにする
"   let g:jedi#popup_select_first = 0
"   " quickrunと被るため大文字に変更
"   let g:jedi#rename_command = '<Leader>R'
"   " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
"   let g:jedi#goto_command = '<Leader>G'
" endfunction
"
"------------------------------

""""""""""""""""""""""""""""""""
"     Colorscheme Settings     "
""""""""""""""""""""""""""""""""
syntax enable

"colorschemeより前に記述.
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
autocmd Colorscheme * highlight Visual ctermbg=8colorscheme

set background=dark
" molokai setting---------------
NeoBundle 'tomasr/molokai'
" colorscheme molokai
set t_Co=256

NeoBundle 'w0ng/vim-hybrid'
colorscheme hybrid

NeoBundle 'sickill/vim-monokai'
" colorscheme monokai

" solarized setting------------
NeoBundle 'altercation/vim-colors-solarized'
" set background=dark
" colorscheme solarized

NeoBundle 'fugalh/desert.vim'
" colorscheme desert

NeoBundle 'kristijanhusak/vim-hybrid-material'
" set background=dark
" colorscheme hybrid_reverse

" インデントに色をつける
NeoBundle 'nathanaelkane/vim-indent-guides'
"vim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup=1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=1
" 自動カラーを無効にする
let g:indent_guides_auto_colors=0
" 奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=237
" 偶数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=240
" ハイライト色の変化の幅
" let g:indent_guides_color_change_percent = 100
" ガイドの幅
let g:indent_guides_guide_size = 1

NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
	\ 'colorscheme': 'solarized',
	\}


" syntax enable " TODO must be written before colorcheme?

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" template settings
autocmd BufNewFile *.v.erb 0r $HOME/.vim/templates/template.v.erb
autocmd BufNewFile *.c 0r $HOME/.vim/templates/template.c


" Key mappings 
" inoremap{ {}<LEFT>
" inoremap( ()<LEFT>
" inoremap[ []<LEFT>
" inoremap" ""<LEFT>
" inoremap' ''<LEFT>
"

" jk で見た目通りに移動
nmap j gj
nmap k gk

" Esc の2回押しでハイライト消去
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" Command-line mode keymappings:
" <C-a>, A: move to head.
cnoremap <C-a>            <Home>
" <C-b>: previous char.
cnoremap <C-b>            <Left>
" <C-d>: delete char.
cnoremap <C-d>            <Del>
" <C-e>, E: move to end.
cnoremap <C-e>            <End>
" <C-f>: next char.
cnoremap <C-f>            <Right>
" <C-n>: next history.
cnoremap <C-n>            <Down>
" <C-p>: previous history.
cnoremap <C-p>            <Up>
" <C-y>: paste.
" cnoremap <C-y>            <C-r>*
" <C-g>: Exit.
" cnoremap <C-g>            <C-c>

inoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <up>

" nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vmap <C-c> :w !xsel -ib<CR><CR>
" noremap <C-j> <esc>
" noremap! <C-j> <esc>
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""
"         Tab Settings          "
""""""""""""""""""""""""""""""""
" Anywhere SID.
" function! s:SID_PREFIX()
"   return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
" endfunction

" Set tabline.
" function! s:my_tabline()  "{{{
"   let s = ''
"   for i in range(1, tabpagenr('$'))
"     let bufnrs = tabpagebuflist(i)
"     let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
"     let no = i  " display 0-origin tabpagenr.
"     let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
"     let title = fnamemodify(bufname(bufnr), ':t')
"     let title = '[' . title . ']'
"     let s .= '%'.i.'T'
"     let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
"     let s .= no . ':' . title
"     let s .= mod
"     let s .= '%#TabLineFill# '
"   endfor
"   let s .= '%#TabLineFill#%T%=%#TabLine#'
"   return s
" endfunction "}}}
" let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map [Tag]c :tablast <bar> tabnew
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

map <silent> <C-l> :tabnext<CR>
map <silent> <C-h> :tabprevious<CR>

map nt :NERDTreeToggle<CR>
