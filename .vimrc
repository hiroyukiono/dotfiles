"----------------
"環境設定
"----------------
set nocompatible
filetype off
if has('vim_starting')
        set runtimepath+=~/.vim/bundle/neobundle.vim
        call neobundle#begin(expand('~/.vim/bundle/'))
        NeoBundleFetch 'Shougo/neobundle.vim'

        "--------------------------------------
        " プラグインを記述
        "--------------------------------------
        NeoBundle 'Shougo/neobundle.vim'
        NeoBundle 'vim-ruby/vim-ruby'
        NeoBundle 'kchmck/vim-coffee-script'
        NeoBundle 'Shougo/neocomplete.vim'
        NeoBundle 'Shougo/unite.vim'
        NeoBundle 'fatih/vim-go'
        NeoBundle 'othree/html5.vim'
        NeoBundle 'hail2u/vim-css3-syntax'
        NeoBundle 'ngmy/vim-rubocop'
        NeoBundle 'scrooloose/syntastic'
        NeoBundle 'osyo-manga/vim-over'
        NeoBundle 'osyo-manga/vim-anzu'
        "--------------------------------------

        call neobundle#end()
endif

filetype plugin on
filetype indent on

syntax on
"絶対行番号
set number
"相対行番号
" set relativenumber
"対応括弧を表示
set showmatch
"不可視文字を表示
set list
" カーソル行の背景色を変える
set cursorline
"オートインデント
set smartindent
"スワップファイルを作らない
set noswapfile
"バックアップファイルを作らない
set nobackup
"マウスを有効
set mouse=a
"エンコーディング
set encoding=utf8
"ファイルエンコーディング
set fileencoding=utf-8
set fileformats=unix,dos,mac
set listchars=tab:>-,trail:~
"対応カッコに<と>のペアを追加
set matchpairs& matchpairs+=<:>
"ステータスライン
set laststatus=2
set t_Co=256
"Tabを空白文字へ置き換える
set expandtab
"無名レジスタとクリップボードを連携させる
set clipboard+=unnamed
set clipboard+=autoselect
"set clipboard=unnamed,autoselect
"set clipboard=unnamedplus
" ビープ音を消す
set vb t_vb=
" ヤンクした内容をクリップボードへ追加する
" command Pbcopy :let @*=@"
" command Pbcopy0 :let @*=@0
" ビジュアルモード<Control + c>でクリップボードへコピー
vmap <C-c> :w !xsel -ib<CR><CR>

"----------------
"キーバインド
"----------------
"バックスペースで各種消せるように
set backspace=indent,eol,start
"ビジュアルモード時vで行末まで移動
vnoremap v $h
inoremap jj <Esc>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
nnoremap ; :
"TABにて対応ペアにジャンプ
nnoremap &lt;Tab&gt; %
vnoremap &lt;Tab&gt; %
"0,9で行頭、行末へ移動
nmap 1 0
nmap 0 ^
nmap 9 $

"----------------
"検索設定
"----------------
"大文字、小文字の区別しない
set ignorecase
"検索時に最後までいったら最初に戻る
set wrapscan
"検索文字列をハイライトする
set hlsearch
"インクリメンタルサーチを行う
set incsearch

"-------------------
"GO Lang
"-------------------
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
"Errをhighlight
" autocmd FileType go :highlight goErr cterm=bold ctermfg=214
" autocmd FileType go :match goErr /\<err\>/

"-------------------
"Unit.vimの設定
"-------------------
"入力モードで開始する
let g:unite_enable_start_insert=1
"バッファ一覧
noremap <C-p> :Unite buffer<CR>
"ファイル一覧
noremap <C-n> :Unite -buffer-name=file file<CR>
"最近使ったファイルの一覧
noremap <C-z> :Unite file_mru<CR>
"sourcesを今開いているディレクトリとする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
"ウィンドウを分割してい開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
"ウィンドウを縦分割してい開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
"ESCを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


"-------------------
"erb indent
"-------------------
autocmd BufRead, BufNewFile *.erb set filetype=eruby.html

"-------------------
"rubocop
"-------------------
let g:syntastic_mode_map = { 'mode': 'active',
                        \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"-------------------
"vim-anzu
"-------------------
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)

"-------------------
"neocomplete
"-------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

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
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
        return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
        For no inserting <CR> key.
        "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

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

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
