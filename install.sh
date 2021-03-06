#!/bin/bash

# This will check which package manager your are running 
declare -A osInfo;
osInfo[/etc/debian_version]="apt-get"
osInfo[/etc/arch-release]="pacman"

#to find the which Os yo are running
for f in ${!osInfo[@]}
do
    if [[ -f $f ]];
    then
         package_manager=${osInfo[$f]}
    fi
done


function good-bye() 
{
    echo -ne "
-------------------------------------------------------------------------
        Thank Your using our Script!!
        Have a Good Day đđ

        Regards  Abdul Rafay
-------------------------------------------------------------------------
"
}

function welcome-Message() 
{
    echo -ne "
-------------------------------------------------------------------------
            Welcome to Kitty Terminal & ZSH Config

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
          This script shouldn't be run as root. âšī¸đ

          Run script like this:-  ./install.sh
-------------------------------------------------------------------------
"
        exit 1
    fi
}


function os()
{
    if [[ "$package_manager" == "pacman" ]];
    then
        arch
    elif [[ "$package_manager" == "apt-get" ]];
    then
        debian_root
    else
        echo 'Error Occured: ${package_manager}'
        exit 0
    fi
}
function arch()
{
    echo -ne "
-------------------------------------------------------------------------
           Arch System is Detected....
-------------------------------------------------------------------------
"
    arch_root
}
function debian()
{
    echo -ne "
-------------------------------------------------------------------------
        Debian System is Detected....
-------------------------------------------------------------------------
"
    debian_root
}
function debian_root()
{   
    echo -ne "
-------------------------------------------------------------------------
           Installing Kitty Terminal
-------------------------------------------------------------------------
"
    sudo apt-get install kitty -y    
}
function arch_root()
{      
    echo -ne "
-------------------------------------------------------------------------
           Installing Kitty Terminal
-------------------------------------------------------------------------
"
    sudo pacman -S kitty --noconfirm
}

function choose_shell()
{
    echo -ne "
-------------------------------------------------------------------------
                --- Choose your Shell ---
        --- Enter from the Following options: ---
        --- 1. Fish Shell ---
        --- 2. ZSh Shell  ---
-------------------------------------------------------------------------
"   
    read -p "
-------------------------------------------------------------------------
            --- Note: use all small caps ---
            --- Enter your Choice ---
-------------------------------------------------------------------------
"  user_choice

    if [[ "$user_choice" == "fish" ]];
    then
        git clone https://github.com/rafay99-epic/Fish-Shell.git
        cd Fish-Shell
        ./install.sh
    elif [[ "$user_choice" == "zsh"  ]];
    then     
        git clone https://github.com/rafay99-epic/ZSH-Shell.git
        cd ZSH-Shell
        ./install.sh
    else
        echo -ne "
-------------------------------------------------------------------------
            --- Sorry You must Choose shell ---
-------------------------------------------------------------------------
"  
        clear
        choose_shell
    fi
}   
function config_kitty()
{
    cp -r kitty ~/.config
}
function reboot_now()
{   
    echo -ne "
-------------------------------------------------------------------------
                --- A Reboot is Required ---
        --- Enter from the Following options: ---
        --- 1. Yes for Reboot system ---
        --- 2. No for Exit the application ---
-------------------------------------------------------------------------
"
    echo -ne "
-------------------------------------------------------------------------
            --- Enter your Choice ---
-------------------------------------------------------------------------
"
    read -p  user_choice

    if [[ "$user_choice" == "yes" || "$user_choice" == "Yes" || "$user_choice" == "YES" || "$user_choice" == "yEs" || "$user_choice" == "yeS"  ]];
    then

        reboot
    elif [[ "$user_choice" == "no" || "$user_choice" == "No" || "$user_choice" == "nO" || "$user_choice" == "NO" ]];
    then     
        good-bye
        exit 0
    else
        good-bye
        exit 0
    fi
}
function run()
{   
    # Welcome Message
    welcome-Message
    
    # check no root
    non-root
    
    # check os and then install application
    os
    
    # this will config the kitty terminal
    config_kitty
    
    # This will give th user two choice to choose a shell
    # 1. ZSH Shell 
    # 2. Fish shell
    choose_shell

    # Reboot option
    reboot_now
    
    # good bye message
    good-bye
}
run