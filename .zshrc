#---------------------
#General Settings
#---------------------
#エンコード
export LANG=ja_JP.UTF-8
#history
HISTFILE=$HOME/.zsh-history
#メモリに保存する履歴の数
HISTSIZE=10000000
#保存する履歴の数
SAVEHIST=10000000
#コアダンプのサイズを制限
limit coredumpsize 102400
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORS
export ZLS_COLORS=$LS_COLORS
#ls自動で色をつける
export CLICOLOR=true
#grepコマンドに色をつける
export GREP_OPTIONS='--color=auto'
#補完候補に色をつける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#出力の末尾に改行コードが無い
unsetopt promptcr
#キーバインドをEmacsモードに設定
bindkey -e
#Use color
setopt prompt_subst
#Don't use beep
setopt nobeep
#jobs long
setopt long_list_jobs
#show file type
setopt list_types
#Auto resume
setopt auto_resume
#auto list
setopt auto_list
setopt hist_ignore_dups
#auto add cd history
setopt auto_pushd
#直前と同じコマンドはヒストリに追加しない
setopt hist_ignore_dups
#ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
#スペースで始まるコマンドはヒストリに追加しない
setopt hist_ignore_space
#dont add history if same directory
setopt pushd_ignore_dups
#automenu
setopt auto_menu
#add start time and end time to history file
setopt extended_history
#コマンドの引数を補完する
autoload -U compinit
compinit
autoload -U colors; colors
#cd後自動でls
function chpwd() {ls --color=auto}
#PATH
export PATH=$PATH:/home/hono/bin

#--------------------
#プロンプトの設定
#--------------------
PROMPT="%F{cyan}%n%f%F{yellow}%f%F%f$ "
RPROMPT="%F{green}[%d]%f"
#コマンド実行直後に右プロンプトを消す
setopt transient_rprompt
#SPROMPT="%r is correct? [n,y,a,e]: "

#コマンドラインの因数でも補完を有効にする
setopt magic_equal_subst
setopt hist_verify
setopt numeric_glob_sort
setopt print_eight_bit
setopt share_history
setopt correct
setopt brace_ccl
#compctl
compctl -f vim
compctl -/ cd
compctl -F man

#--------------------
#Gitブランチ名を表示
#--------------------
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{red}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示
precmd() {vcs_info}
RPROMPT=$RPROMPT'${vcs_info_msg_0_}%{${reset_color}%}'

#---------------
#peco履歴設定
#---------------
function peco-select-history() {
local tac
if which tac > /dev/null; then
        tac="tac"
else
        tac="tail -r"
fi
BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
CURSOR=$#BUFFER
zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

#---------------
# colordiff
#---------------
if [ -x "$(which colordiff)" ]; then
            alias diff="colordiff -u"
fi

#----------------------------------------------------
# コマンド実行時に候補を表示するzsh-autosuggestions
#----------------------------------------------------
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#---------------
#aliasの設定
#---------------
alias rm="rm -rf"
alias cp="cp -i"
alias mv="mv -i"
alias na-git="ssh hono@10.30.2.69"
alias na-doc="ssh hono@10.30.158.203"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias log_tail="tail /var/log/system.log"
alias ga="git add -p"
alias gl="git log"
alias gll="git log --all --oneline --date-order"
alias gc="git commit"
alias gba="git branch -a"
alias gb="git branch"
alias gs="git status"
alias gr="git remote -v"
alias tm="tmux"
alias gch="git checkout"
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -l"
alias tig="tig --all"
alias gf="(){git-foresta --graph-symbol-merge=★  --graph-symbol-overpass== | less -RSX}"
alias gfa="(){git-foresta --all --graph-symbol-merge=★  --graph-symbol-overpass== | less -RSX}"
