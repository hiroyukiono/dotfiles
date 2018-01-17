#!/bin/sh

DOT_FILES=".zshrc .zshenv .vimrc .tmux.conf .tigrc .tigrc.vim"

NEOBUNDLE_GIT_URL="git://github.com/Shougo/neobundle.vim"
NEOBUNDLE_DIST_DIR="$HOME/.vim/bundle/neobundle.vim"

# DOT_FILESをホームディレクトリへ配置
for file in ${DOT_FILES}
do
   ln -s $HOME/dotfiles/$file $HOME/$file
done

# Neobundleをセットアップ
mkdir -p $HOME/.vim/bundle
git clone ${NEOBUNDLE_GIT_URL} ${NEOBUNDLE_DIST_DIR}
