#!/bin/bash
CWD=$(pwd)
DIR_NAME=$(dirname $0)
echo $DIR_NAME
segments=$(echo $DIR_NAME | tr "\/" "\n")
CONFIG_PATH=$CWD
for seg in $segments
do
    CONFIG_PATH=$CONFIG_PATH/$seg
done
echo config path: $CONFIG_PATH
# install oh my zsh
if [ -d ~/.oh-my-zsh ]; then
    echo "zsh already exists."
else
    echo "Installing zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "zsh installed."
fi

# install nvm
if [ -d ~/.nvm ]; then
    echo "nvm already exists."
else
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    echo "nvm installed."
fi

# install miniconda
echo "Installing miniconda..."

# install powerline fonts
echo "Installing powerline fonts..."
bash $CONFIG_PATH/fonts/install.sh

# install Vundle
if [ -d ~/.vim/bundle/Vundle.vim ]; then
    echo "Vundle already exists."
else
    echo "Installing Vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# linking config files
echo "Linking config files..."
rm ~/.zshrc
rm ~/.vimrc
ln -s $CONFIG_PATH/zsh/.zshrc ~/.zshrc
ln -s $CONFIG_PATH/vim/.vimrc ~/.vimrc
rm -rf ~/.vim/colors/solarized.vim
ln -s $CONFIG_PATH/vim/colors/solarized.vim ~/.vim/colors/solarized.vim

# install vim plugins
vim +PluginInstall +qall

