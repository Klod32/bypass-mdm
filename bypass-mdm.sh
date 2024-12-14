#!/bin/bash

# Define color codes
RED='\033[1;31m'
GRN='\033[1;32m'
BLU='\033[1;34m'
YEL='\033[1;33m'
PUR='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m'

# Display header
echo -e "${CYAN}Bypass MDM By Assaf Dori (assafdori.com)${NC}"
echo ""

# Prompt user for choice
PS3='Please enter your choice: '
options=("Bypass MDM from Recovery" "Reboot & Exit")
select opt in "${options[@]}"; do
    case $opt in
        "Bypass MDM from Recovery")
            # Bypass MDM from Recovery
            echo -e "${YEL}Bypass MDM from Recovery"
            
            # Create Temporary User
            echo -e "${NC}Create a Temporary User"
            read -p "Enter Temporary Fullname (Default is 'Apple'): " realName
            realName="${realName:=Apple}"
            read -p "Enter Temporary Username (Default is 'Apple'): " username
            username="${username:=Apple}"
            read -p "Enter Temporary Password (Default is '1234'): " passw
            passw="${passw:=1234}"

            # Block MDM domains
            echo "0.0.0.0 deviceenrollment.apple.com" >>/Volumes/Sequoia/etc/hosts
            echo "0.0.0.0 mdmenrollment.apple.com" >>/Volumes/Sequoia/etc/hosts
            echo "0.0.0.0 iprofiles.apple.com" >>/Volumes/Sequoia/etc/hosts
            echo -e "${GRN}Successfully blocked MDM & Profile Domains"

            # Remove configuration profiles
            touch /Volumes/Sequoia/private/var/db/.AppleSetupDone
            rm -rf /Volumes/Sequoia/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
            rm -rf /Volumes/Sequoia/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
            touch /Volumes/Sequoia/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
            touch /Volumes/Sequoia/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound

            echo -e "${GRN}MDM enrollment has been bypassed!${NC}"
            echo -e "${NC}Exit terminal and reboot your Mac.${NC}"
            break
            ;;
        "Reboot & Exit")
            # Reboot & Exit
            echo "Rebooting..."
            reboot
            break
            ;;
        *) echo "Invalid option $REPLY" ;;
    esac
done
