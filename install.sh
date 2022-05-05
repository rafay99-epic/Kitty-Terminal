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
}
function remove_permissions()
{
    chmod -x install-zsh.sh
    chmod -x theme-zsh.sh
}
function run-script()
{
    sudo ./install-zsh.sh
    ./theme-zsh.sh
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

    give-permissions
    
    run-script

    remove-permissions

    good-bye


}
