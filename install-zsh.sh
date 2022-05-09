#!/bin/bash

# This will check which package manager your are running 
declare -A osInfo;
osInfo[/etc/debian_version]="apt-get"
osInfo[/etc/alpine-release]="apk"
osInfo[/etc/centos-release]="yum"
osInfo[/etc/fedora-release]="dnf"
osInfo[/etc/arch-release]="pacman"

#to find the which Os yo are running
for f in ${!osInfo[@]}
do
    if [[ -f $f ]];
    then
         package_manager=${osInfo[$f]}
    fi
done

function root() 
{
    # Checking for root access and proceed if it is present
    ROOT_UID=0
    if [[ ! "${UID}" -eq "${ROOT_UID}" ]]; then
        echo -ne "
-------------------------------------------------------------------------
           This script shouldn be run as root. ☹️🙁

           Run script like this:-  sudo ./install-zsh.sh
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
        debian
    else
        echo 'Error Occured: ${package_manager}'
        exit 0
    fi
}
function debian()
{   
    echo -ne "
-------------------------------------------------------------------------
            Debain System is Detected
-------------------------------------------------------------------------
"

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
function arch()
{
    echo -ne "
-------------------------------------------------------------------------
            Arch System is Detected
-------------------------------------------------------------------------
"

    echo -ne "
-------------------------------------------------------------------------
           Installing Paru
-------------------------------------------------------------------------
"
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ../  

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
function change-Shell()
{
    echo -ne "
-------------------------------------------------------------------------
           Changing Default Shell to ZSH
-------------------------------------------------------------------------
"
    chsh -s /bin/zsh
}
function run()
{   
    echo -ne "
-------------------------------------------------------------------------
            Running Applications-Installer...
-------------------------------------------------------------------------
"
    root
    os
    program
    change-Shell
}
run
