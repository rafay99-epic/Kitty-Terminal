#!/bin/bash
function non-root() 
{
    if [ "$USER" = root ]; then
        echo -ne "
-------------------------------------------------------------------------
          This script shouldn't be run as root. ☹️🙁

          Run script like this:-  ./non-root-app.sh
-------------------------------------------------------------------------
"
        exit 1
    fi
}
function paru-install()
{
    echo -ne "
-------------------------------------------------------------------------
           Installing Paru
-------------------------------------------------------------------------
"
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si
        cd ../
}
function application_install()
{
    echo -ne "
-------------------------------------------------------------------------
           Installing  ccat
-------------------------------------------------------------------------
"
    paru -S ccat --noconfirm --needed

    echo -ne "
-------------------------------------------------------------------------
           Installing  Powerline-font
-------------------------------------------------------------------------
"
    paru -S powerline-fonts-git --noconfirm --needed

    echo -ne "
-------------------------------------------------------------------------
           Installing  Awesome-font
-------------------------------------------------------------------------
"
    paru -S font-awesome-5 --noconfirm --needed
}
function change-Shell()
{
    echo -ne "
-------------------------------------------------------------------------
           Changing Default Shell to ZSH
-------------------------------------------------------------------------
"
    chsh -s /bin/zsh
}
function install-non-root-app () 
{
    echo -ne "
-------------------------------------------------------------------------
    Running Applications-Installer As User Privillages...
-------------------------------------------------------------------------
"
    non-root
    paru-install
    application_install
    change-Shell
}
install-non-root-app