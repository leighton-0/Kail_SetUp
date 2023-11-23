#!/bin/bash
# icons
# ❌⏳💀🎉 ℹ️ ⚠️ 🚀 ✅ ♻ 🚮 🛡 🔧  ⚙ 

# Install --->> curl https://raw.githubusercontent.com/leighton-0/Kail_SetUp/main/setup_nord_deluge.sh | bash

# ################################
# Installs Nordvpn & deluge
# ################################

user=kali
downloads=/home/"$user"/Downloads

# set colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE="\033[01;34m" # Heading
NO_COLOR='\033[0m'
CLEAR_LINE='\r\033[K'
BOLD="\033[01;01m" # Highlight
RESET="\033[00m" # Normal

# set env variable for apt-get installs
export DEBIAN_FRONTEND=noninteractive

# verify running as root
if [[ "${EUID}" -ne 0 ]]; then
  echo -e ' '${RED}'[!]'${RESET}" This script must be ${RED}run as root${RESET}" 1>&2
  echo -e ' '${RED}'[!]'${RESET}" Quitting..." 1>&2
  exit 1
fi


# enable https repository
cat <<EOF >/etc/apt/sources.list
deb https://http.kali.org/kali kali-rolling main non-free contrib
#The kali Rolling Repository
deb http://repo.kali.org/kali kali-rolling main contrib non-free
deb-src http://repo.kali.org/kali kali-rolling main contrib non-free
EOF

compute_start_time(){
    start_time=$(date +%s)
    echo "\n\n Install started - $start_time \n" >> script.log
}

printf "  ⏳  install & logon to nordvpn\n" | tee -a script.log
    # ref:- https://www.ceos3c.com/linux/install-nordvpn-linux/
    cd /home/kali/Downloads
    wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
    apt install /home/kali/Downloads/nordvpn-release_1.0.0_all.deb
    apt update -y
    apt install nordvpn -y
    nordvpn login --token $TOKEN
    nordvpn connect Double VPN
    nordvpn s killswitch on
    # #nordvpn connect "#656"
    # #nordvpn -c -n "United States #3710"
    # nordvpn connect --group Dedicated_IP Germany
    printf '\n============================================================\n'
    printf '[+] NordVPN NordVPN status\n'
    nordvpn status
    printf '============================================================\n\n'
    sleep 5
    

configure_environment(){
    echo "HISTTIMEFORMAT='%m/%d/%y %T '" >> /root/.bashrc
}

nordvpn() {
    printf "  ⏳  install nordvpn with wireguard\n" | tee -a script.log
    git clone https://github.com/sfiorini/NordVPN-Wireguard/blob/master/NordVpnToWireguard.sh
    chmod +x NordVpnToWireguard.sh
    sudo apt install wireguard curl jq net-tools   # install reqd packages
    sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)   # install nord client
    nordvpn login --token $TOKEN
    nordvpn set technology nordlynx
    ./NordVpnToWireguard.sh
    printf '\n============================================================\n'
    printf '[+] NordVPN NordVPN status\n'
    nordvpn status
    printf '============================================================\n\n'
    sleep 5
    
    


apt_update() {  
    printf "  ⏳  apt update\n" | tee -a script.log
    apt update -qq >> script.log 2>>script_error.log
}

apt_upgrade() {
    printf "  ⏳  apt upgrade\n" | tee -a script.log
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq >> script.log 2>>script_error.log
}

install_brave(){
    printf "  ⏳  Installing Opera browser\n" | tee -a script.log
    curl -s https://raw.githubusercontent.com/nu11secur1ty/Kali-Linux/master/brave-browser-Kali-Linux/kukurus.sh | bash
}

install_mega() {
    printf "  ⏳  Installing MEGAsync\n" | tee -a script.log
    cd "$downloads"
    wget --quiet https://mega.nz/linux/MEGAsync/Debian_10.0/amd64/megasync-Debian_10.0_amd64.deb
    if [[ $? != 0 ]]; then
        printf "${CLEAR_LINE}❌${RED} $1 failed ${NO_COLOR}\n"
        echo "$1 failed " >> script.log
    fi
    dpkg -i ./megasync-Debian_10.0_amd64.deb >> script.log
    apt --fix-broken install -y
    rm -f ./megasync-Debian_10.0_amd64.deb
}

gedit() {
    printf "  ⏳  Install Gedit\n" | tee -a script.log
    apt install gedit -y
}

deluge() {
     printf "  ⏳  Install deluge\n" | tee -a script.log
     sleep $s
     apt install deluge -y
}

auto_mac_spoof() {
    printf "  ⏳  Auto MAC spoof on start up - assuming wlan0\n" | tee -a script.log
    #touch /etc/systemd/system/changemac@.service
    wget -P /etc/systemd/system https://raw.githubusercontent.com/leighton-0/kali-setup/master/changemac@.service
    systemctl enable changemac@wlan0.service
}

Auto_Random_Host_name() {
    printf "  ⏳  install_Auto Random Host name\n" | tee -a script.log
    git clone https://github.com/tasooshi/namechanger.git
    cd namechanger
    make install
    cd ~
}

install_nano() {
    printf "  ⏳  Installing nano from binaries\n" | tee -a script.log
    # install nano from binaries
    wget https://www.nano-editor.org/dist/v7/nano-7.2.tar.gz
    tar -zxvf nano-7.2.tar.gz
    cd nano-7.2
    sudo apt install libncurses-dev
    ./configure
    make
    make install
    # set up colour text ref:- https://askubuntu.com/questions/90013/how-do-i-enable-syntax-highlighting-in-nano
    find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; >> ~/.nanorc
}

compute_finish_time(){
    finish_time=$(date +%s)
    echo -e "  ⌛ Time (roughly) taken: ${YELLOW}$(( $(( finish_time - start_time )) / 60 )) minutes${RESET}"
    echo "\n\n Install completed - $finish_time \n" >> script.log
}

main () {
    compute_start_time
    configure_environment
    apt_update
    apt_upgrade
    install_brave
    #install_mega
    gedit
    #terminator
    deluge
    #Auto_Random_Host_name
    #auto_mac_spoof
    #install_add_WP_recon
    install_nano
    #manual_stuff_to_do
    compute_finish_time
    #script_todo_print
}

main
