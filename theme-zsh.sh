#!/bin/bash

function non-root() 
{
    if [ "$USER" = root ]; then
        echo -ne "
-------------------------------------------------------------------------
          This script shouldn't be run as root. ☹️🙁

          Run script like this:-  ./theme-zsh.sh
-------------------------------------------------------------------------
"
        exit 1
    fi
}

function config-theme()
{   
    echo -ne "
-------------------------------------------------------------------------
            Placing the Dot Files for ZSH
-------------------------------------------------------------------------
"
    # Placing the files
    mv ~/Kitty-Terminal/.zshrc   ~/
    mv ~/Kitty-Terminal/.zsh_history  ~/

    echo -ne "
-------------------------------------------------------------------------
        Placing Kitty Terminal Config Files
-------------------------------------------------------------------------
"
    # placing the kitty config files
    mv ~/Kitty-Terminal/kitty  ~/.config/

    echo -ne "
-------------------------------------------------------------------------
        Installing  Star-Ship Promote
-------------------------------------------------------------------------
"
    # Instaiing starship theme for zsh
    curl -sS https://starship.rs/install.sh | sh
    # git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    # ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

#     echo -ne "
# -------------------------------------------------------------------------
#         Installing Oh-My-ZSH 
# -------------------------------------------------------------------------
# "
#      # This will install on-my-zsh
#     sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    #This will download and config the zsh-snapper manager 
    # git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git
    # source zsh-snap/install.zsh

    # # This wil config the auto-predication in zsh shell
    # znap source marlonrichert/zsh-autocomplete
}



function runner()
{
    echo -ne "
-------------------------------------------------------------------------
            Running The Config Files...
-------------------------------------------------------------------------
"
    non-root
    config-theme
}
runner
