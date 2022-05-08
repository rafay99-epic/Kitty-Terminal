#!/bin/bash

# Location of Paru
PARU=/usr/bin/paru

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
    clear
    echo -ne "
-------------------------------------------------------------------------
           Installing ZSH Shell
-------------------------------------------------------------------------
"
    sudo apt-get install zsh -y
    clear
    
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
           Installing Kitty Terminal
-------------------------------------------------------------------------
"
    sudo pacman -S kitty --noconfirm
    clear
    
    echo -ne "
-------------------------------------------------------------------------
           Installing ZSH Shell
-------------------------------------------------------------------------
"
    sudo pacman -S zsh --noconfirm
    clear

    ccat_program
    
    clear
}
function ccat_program()
{

    if [[ "$package_manager" == "pacman" ]];
    then 
        if [ ! -e "$PARU" ]; 
        then
            clear
            echo -ne "
-------------------------------------------------------------------------
           Installing Paru and ccat
-------------------------------------------------------------------------
"
            sudo pacman -S paru --noconfirm --needed
            paru -S ccat --noconfirm --needed
        else
            clear
            echo -ne "
-------------------------------------------------------------------------
           Paru is Installed & Installing ccat
-------------------------------------------------------------------------
"
            paru -S ccat --noconfirm --needed
        fi
    fi
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
    clear  
}
function change-Shell()
{
    echo -ne "
-------------------------------------------------------------------------
           Changing Default Shell to ZSH
-------------------------------------------------------------------------
"
    if [[ "$package_manager" == "pacman" ]];
    then
        echo " "
        echo "Enter Your User Password to change your default shell"
        chsh -s /bin/zsh  
    elif [[ "$package_manager" == "apt-get" ]];
    then
        echo " "
        echo "Enter Your User Password to change your default shell"
        chsh -s /bin/zsh    
    else
        echo 'Error Occured: ${package_manager}'
        exit 0
    fi
    clear
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
