#!/bin/bash
# ============================
# WORKING OK NEEDS INTEGRATING INTO MAIN SCRIPT
# ===========================

# run using  curl https://raw.githubusercontent.com/leighton-0/Kail_SetUp/main/sandbox_nord.sh | bash

# enable https repository
cat <<EOF >/etc/apt/sources.list
deb https://http.kali.org/kali kali-rolling main non-free contrib
EOF
apt update -y && apt upgrade -y

printf "  🔧  install & logon to nordvpn\n" | tee -a script.log
    # ref:- https://www.ceos3c.com/linux/install-nordvpn-linux/
    cd /home/kali/Downloads
    wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
    sudo apt install /home/kali/Downloads/nordvpn-release_1.0.0_all.deb
    sudo apt update -y
    sudo apt install nordvpn -y
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
    apt install deluge -y 
