#!/bin/sh

## Oh-My-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]
then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "oh-my-zsh already installed"
fi

## Plugins

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/wakatime" ]
then
    git clone https://github.com/sobolevn/wakatime-zsh-plugin.git $HOME/.oh-my-zsh/custom/plugins/wakatime
else
    echo "wakatime already installed"
fi


if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]
then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting already installed"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]
then
    git clone https://github.com/zsh-users/zsh-completions.git $HOME/.oh-my-zsh/custom/plugins/zsh-completions
else
    echo "zsh-completions installed"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]
then
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions already installed"
fi

##Fonts

#https://www.nerdfonts.com/font-downloads
#https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/BitstreamVeraSansMono.zip
FONTS_DIR="$HOME/.fonts"

if [ ! -d "$FONTS_DIR" ]
then
    mkdir $FONTS_DIR
else
    echo "fonts dirictory already exist"
fi
wget -P $FONTS_DIR 'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/BitstreamVeraSansMono.zip' && unzip $FONTS_DIR/BitstreamVeraSansMono.zip -d $FONTS_DIR

	

##Theme
if [ ! -d "$HOME/.oh-my-zsh/themes/powerlevel10k" ]
then
    git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/themes/powerlevel10k
else
    echo "powerlevel10k already installed"
fi
