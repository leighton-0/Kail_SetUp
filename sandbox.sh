#!/bin/bash

# run using  curl https://raw.githubusercontent.com/leighton-0/Kail_SetUp/main/sandbox.sh | bash

printf "  🔧  install & logon to nordvpn\n" | tee -a script.log
    s=5
    # ref:- https://www.ceos3c.com/linux/install-nordvpn-linux/
    # if [ ! -f '~/nordvpn*']
    # then
    cd /home/kali/Downloads
    if [ ! -f './nordvpn*']; then
    wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
    sudo apt-get install /home/kali/Downloads/nordvpn-release_1.0.0_all.deb
    fi
    << 'COMMENT'
    sudo apt-get update -y
    sudo apt-get install nordvpn -y
    apt install -y ./nordvpn-release_1.0.0_all.deb
    # token 30 day expiring - 11 December
    # e9f2ab4ec9525094e607b4b25633c2e890e60c200af048a5ef8202dd47b8386e0403
    # read -n 1 -p "input token" 
    nordvpn login --token e9f2ab4ec9525094e607b4b25633c2e890e60c200af048a5ef8202dd47b8386e
    sleep $s
    nordvpn connect Double VPN
    sleep $s
    nordvpn s killswitch on
    # #nordvpn connect "#656"
    # #nordvpn -c -n "United States #3710"
    # nordvpn connect --group Dedicated_IP Germany
    # sleep 10
    nordvpn status
    sleep 10
    COMMENT
