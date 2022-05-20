#!/bin/bash

#Location for Paru
PARU=/usr/bin/paru

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
        Have a Good Day 🙂😊

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
          This script shouldn't be run as root. ☹️🙁

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
    arch_noroot
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
    echo -ne "
-------------------------------------------------------------------------
           Installing ZSH Shell
-------------------------------------------------------------------------
"
    sudo apt-get install zsh -y

    echo -ne "
-------------------------------------------------------------------------
           Installing LSD
-------------------------------------------------------------------------
"
    sudo dpkg -i lsd.deb

    echo -ne "
-------------------------------------------------------------------------
           Installing Powerline  Fonts
-------------------------------------------------------------------------
"
    sudo apt-get install -y fonts-powerline    

    echo -ne "
-------------------------------------------------------------------------
           Installing Awesome Fonts
-------------------------------------------------------------------------
"
    sudo apt-get install -y fonts-font-awesome
    
}
function arch_root()
{
    echo -ne "
-------------------------------------------------------------------------
           Installing Base-Devel Packages
-------------------------------------------------------------------------
"
    sudo pacman -S  base-devel  --noconfirm --needed
      

    echo -ne "
-------------------------------------------------------------------------
           Installing Kitty Terminal
-------------------------------------------------------------------------
"
    sudo pacman -S kitty --noconfirm
    
    echo -ne "
-------------------------------------------------------------------------
           Installing ZSH Shell
-------------------------------------------------------------------------
"
    sudo pacman -S zsh --noconfirm

    echo -ne "
-------------------------------------------------------------------------
           Installing LSD
-------------------------------------------------------------------------
"
    sudo pacman -S lsd --noconfirm --needed
}
function program()
{
        echo -ne "
-------------------------------------------------------------------------
           Installing Fetch Master 6000
-------------------------------------------------------------------------
"
    git clone https://github.com/anhsirk0/fetch-master-6000.git
    cd fetch-master-6000
    chmod +x install.sh
    sudo ./install.sh
    cd ../
}

function arch_noroot() 
{
    paru-install
    application_install
}


function paru-install()
{
    if [ ! -e "$PARU" ]; 
        then
            sudo pacman -S base-devel --noconfirm -needed
            echo -ne "
-------------------------------------------------------------------------
           Installing Paru
-------------------------------------------------------------------------
"
            git clone https://aur.archlinux.org/paru.git
            cd paru
            makepkg -si
            cd ../
        else
            echo -ne "
-------------------------------------------------------------------------
           Paru is already installed...
-------------------------------------------------------------------------
"
        fi    
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
    # There is a confit in font packages that why remoing ttf-hack font 
    paru -R ttf-hack --noconfirm
    # Installing powerline font
    paru -S powerline-fonts-git --noconfirm --needed

    echo -ne "
-------------------------------------------------------------------------
           Installing  Awesome-font
-------------------------------------------------------------------------
"   
    # Installing ttf-awesome fonts
    paru -S ttf-font-awesome --noconfirm --needed

}

function change-Shell()
{
    echo -ne "
-------------------------------------------------------------------------
           Changing Default Shell to ZSH
           User Password is Required
-------------------------------------------------------------------------
"
    chsh -s /bin/zsh
}
function theme()
{
    echo -ne "
-------------------------------------------------------------------------
            Config Themes
-------------------------------------------------------------------------
"
    echo -ne "
-------------------------------------------------------------------------
        Installing  Star-Ship Promote
-------------------------------------------------------------------------
"
    # Instaiing starship theme for zsh
    curl -sS https://starship.rs/install.sh | sh

    echo -ne "
-------------------------------------------------------------------------
            Placing the Dot Files for ZSH
-------------------------------------------------------------------------
"
    # Placing the files
    mv ~/Kitty-Terminal/.zshrc   ~/
    
    echo -ne "
-------------------------------------------------------------------------
        Placing Kitty Terminal Config Files
-------------------------------------------------------------------------
"
    # placing the kitty config files
    mv ~/Kitty-Terminal/kitty  ~/.config/
}

function run()
{   
    # Welcome Message
    welcome-Message
    # check no root
    non-root
    # check os and then install application
    os
    # install fm60000  
    program
    # config theme and install startpromte
    theme
    #change shell 
    change-Shell
    # good Bye message
    good-bye
    exit 0
}
run