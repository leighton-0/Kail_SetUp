#!/bin/bash

printf "  ⏳  install brave browser\n" | tee -a script.log

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg\\
https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg]\
https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.lis

sudo apt update

sudo apt install brave-browser
