#!/bin/bash

# run using  curl https://raw.githubusercontent.com/leighton-0/Kail_SetUp/main/sandbox.sh | bash

# enable https repository
cat <<EOF >/etc/apt/sources.list
deb https://http.kali.org/kali kali-rolling main non-free contrib
EOF

#token=e9f2ab4ec9525094e607b4b25633c2e890e60c200af048a5ef8202dd47b8386e0403
#echo "enter nordvpn token eg e9f2ab4ec9525094e607b4b25633c2e890e60c200af048a5ef8202dd47b8386e0403"
read -p -i "what is the token?  eg e9f2ab4ec9525094e607b4b25633c2e890e60c200af048a5ef8202dd47b8386e0403" token

printf "  🔧  install & logon to nordvpn\n" | tee -a script.log
    s=5
    # ref:- https://www.ceos3c.com/linux/install-nordvpn-linux/
    cd /home/kali/Downloads
    wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
    sudo apt install /home/kali/Downloads/nordvpn-release_1.0.0_all.deb
    sudo apt update -y
    sudo apt install nordvpn -y
    # token 30 day expiring - 11 December
    # e9f2ab4ec9525094e607b4b25633c2e890e60c200af048a5ef8202dd47b8386e0403
    # read -n 1 -p "input token" 
    nordvpn login --token $token
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
    printf "  🔧  THE END\n" 
