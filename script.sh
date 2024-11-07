#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  sudo "$0" "$@"
  exit
fi

echo "Cyberpatriot Basic Script"
echo "Firewall......................1"
echo "Updates and Upgrades..........2"
echo "Configure /etc/login.defs.....3"

read -p "Which command do you want to run? " command_value

if [[ $command_value == 1 ]]; then
  sudo ufw enable
  sudo ufw status
  echo "Firewall is enabled"
fi

if [[ $command_value == 2 ]]; then
  sudo apt-get update && sudo apt-get upgrade -y
  echo "apt-update and apt-upgrade run"
fi

if [[ $command_value == 3 ]]; then
  sed -i 's/^PASS_MAX_DAYS.*$/PASS_MAX_DAYS  15/' /etc/login.defs
    echo "Password maximum age set"
    echo ""
  sed -i 's/^PASS_MIN_DAYS.*$/PASS_MIN_DAYS  7/' /etc/login.defs
    echo "Password minimum age set"
    echo ""
  sed -i 's/^PASS_WARN_AGE.*$/PASS_WARN_AGE  7/' /etc/login.defs
    echo "Password warn age set"
    echo ""
fi

echo "---------------------------------"
read -p "Anything else (y or n): " yn_rerun
if [[ $yn_rerun == "y" ]]; then
  "$0"
else
  exit
fi
