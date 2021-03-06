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
        NeoBundle 'ngmy/vim-rubocop'
        NeoBundle 'rickhowe/diffchar.vim'
        NeoBundle 'scrooloose/syntastic'
        NeoBundle 'vim-ruby/vim-ruby'
        NeoBundle 'rhysd/vim-clang-format'
        NeoBundle 'kana/vim-operator-user'
        "--------------------------------------

        call neobundle#end()
endif

filetype plugin on
filetype indent on

syntax on
"絶対行番号
" set number
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
" ビープ音を消す
set vb t_vb=
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
"rubocop
"-------------------
let g:syntastic_mode_map = { 'mode': 'active',
                        \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"--------------------------------------
" APIランタイムエラーのソートチェック
"--------------------------------------
augroup noah_sort_checker
  autocmd!
  autocmd BufEnter */build/system/api/sysapi/app/resources/api_runtime_errors.yml :!noah_sort_checker '%:p'
  autocmd BufWritePost */build/system/api/sysapi/app/resources/api_runtime_errors.yml :!noah_sort_checker '%:p'
augroup END

"-------------------
" vimdiff
"-------------------
" vimdiffで起動した際自動的に単語単位の差分(diffchar.vim)を有効にする
if &diff
  augroup enable_diffchar
    autocmd!
    autocmd VimEnter * execute "%SDChar"
  augroup END
endif
" 編集中に差分ハイライトを自動で更新するかどうか。デフォルトは0(更新しない)。
let g:DiffUpdate = 1

"---------------------------
" C言語の自動フォーマット
"---------------------------
autocmd FileType c ClangFormatAutoEnable


"----------------------
" Vimステータスライン
"----------------------
" 常に Status Line を表示する
set statusline=%F " ファイル名表示
set statusline+=\ \   " 空白スペース2個
set statusline+=%m " 変更チェック表示
set statusline+=%r " 読み込み専用かどうか表示
set statusline+=%h " ヘルプページなら[HELP]と表示
set statusline+=%w " プレビューウインドウなら[Prevew]と表示
set statusline+=[ENC=%{&fileencoding}] " file encoding
set statusline+=\ \   " 空白スペース2個
set statusline+=[POS=%l/%L(%02v)] " 現在行数/全行数(ポジション)
set statusline+=\ \   " 空白スペース2個
set laststatus=2 " ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
" set statusline+=%= " これ以降は右寄せ表示
