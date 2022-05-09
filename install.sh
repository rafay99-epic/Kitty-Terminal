#!/bin/bash


function good-bye() 
{
    echo -ne "
-------------------------------------------------------------------------
        Thank Your using our Script!!
        Have a Good Day 🙂😊

        Regards  Abdul Rafay
-------------------------------------------------------------------------
"
}

function welcome-Message() 
{
    echo -ne "
-------------------------------------------------------------------------
            Welcome to Config ZSH Shell and Kitty Terminal

            Author: Abdul Rafay
            Email: 99marafay@gmail.com
            GitHub: rafay99-epic
-------------------------------------------------------------------------
"
}

function non-root() 
{
    if [ "$USER" = root ]; then
        echo -ne "
-------------------------------------------------------------------------
          This script shouldn't be run as root. ☹️🙁

          Run script like this:-  ./install.sh
-------------------------------------------------------------------------
"
        exit 1
    fi
}
function give_permissions() 
{
    chmod +x install-zsh.sh
    chmod +x theme-zsh.sh
    chmod +x checkOS.sh
}
function remove_permissions()
{
    chmod -x install-zsh.sh
    chmod -x theme-zsh.sh
    chmod -x checkOS.sh
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
function script-run()
{
    sudo ./install-zsh.sh
    ./theme-zsh.sh
}
function run-script()
{
    . checkOS.sh

    if [[ "$package_manager" == "pacman" ]];
    then
        paru-install
        script-run
    elif [[ "$package_manager" == "apt-get" ]];
    then
        script-run
    else
        echo 'Error Occured: ${package_manager}'
        exit 0
    fi

    echo -ne "
-------------------------------------------------------------------------
     Kitty Terminal & ZSh are configured !! ✨ Congratulation ✨ 
-------------------------------------------------------------------------
"

}
function begin()
{
    non-root

    welcome-Message

    give_permissions
    
    run-script

    remove_permissions

    good-bye

}
begin