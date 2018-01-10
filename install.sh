#!/bin/bash

DATE=$(date +%Y%m%d)
DIR=$(pwd)
ZSHRC=1


#Vims conf
cp -v ctags ~/.ctags
rm -rf $HOME/.vim
cp -Rv $DIR/vim/ $HOME/.vim/
ln -sf  $HOME/.vim/vimrc $HOME/.vimrc
cp -v tmux.conf ~/.tmux.conf
cp -v psqlrc ~/.psqlrc
cp -rfv psqlrc_alias ~/.psqlrc_alias
cp -Rfv bin ~/bin
cp -v dev_requirements.txt ~/.dev_requirements.txt

cd /tmp/
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
if [ $ZSHRC  ];
then
    chsh -s /bin/zsh
    echo "Installing zsh on the machine"
fi

cd $DIR

cp -Rv zshrc $HOME/.zshrc
cp -Rv bash_aliases $HOME/.bash_aliases
cp -Rv ssh/* $HOME/.ssh/
cp -v gitconfig ~/.gitconfig

sudo pip install virtualenvwrapper

if [ $(uname) =  "Darwin" ]; then
    cp launch/* ~/Library/LaunchAgents/
    ls -1 launch/* | while read line;
    do
        lib=$(echo $line | awk -F '/' '{print $2}')
        echo "launchctl load ~/Library/LaunchAgents/$lib"
    done
fi
