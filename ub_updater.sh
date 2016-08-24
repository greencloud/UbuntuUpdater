#!/bin/bash

# CHANGE THIS TO YOUR OWN USERNAME (/home/username)
USR=greencloud

clear
# Defined color settings
RED=$(tput setaf 1 && tput bold)
GREEN=$(tput setaf 2 && tput bold)
BLUE=$(tput setaf 6 && tput bold)
NORM=$(tput sgr0)

echo ""
echo ""
echo ""
echo $RED"          +###################################################+"
echo $RED"          +                                                   +"
echo $RED"          +     Ubuntu Linux System Updater Script v.0.1      +"
echo $RED"          +                                                   +"
echo $RED"          +                  By Greencloud                    +"
echo $RED"          +                                                   +"
echo $RED"          +###################################################+"
echo ""
echo ""
echo $BLUE"    This script is intended to automate system update and at the same"
echo $BLUE"    time run a cleanup and virus quick-scan utility. Enjoy! :)"
echo ""
echo $RED"     IMPORTANT: Make sure you run this script as a root (with 'sudo')"
echo ""
echo ""
echo ""
sleep 5
clear

echo $RED"    >>>>> UPDATING SYSTEM FROM STANDARD REPO <<<<<"
# Update system
echo $GREEN""
apt-get update -f
apt-get -y upgrade
apt-get -y dist-upgrade
echo "DONE!"
echo ""
sleep 2
clear

echo $RED"    >>>>> Updating ClamScan Anti-virus program <<<<<"
echo $RED"            --- THIS MIGHT TAKE A WHILE ----"
# Update Anti-virus
# If there's no anti-virus found, install ClamAV
echo $GREEN""
CLAMFILE=/usr/bin/clamscan
CLAMAVLOG=/var/log/clamav/freshclam.log
if [ ! -f $CLAMFILE ]; then
	echo $RED"    !!!! NO ANTI-VIRUS INSTALLED - INSTALLING CLAMAV !!!!"
	echo $STAND""
	apt-get install -y clamscan clamav-daemon
fi
if [ -f $CLAMAVLOG ]; then
	freshclam
	tail -10 $CLAMAVLOG
fi
echo "DONE!"
echo ""
sleep 5
clear

echo $NORM"    >>>>> RUNNING THE CLEAN UP PROCESS <<<<<"
# Clean system
echo $GREEN""
apt-get clean
apt-get -y autoclean
apt-get -y autoremove
echo "DONE!"
echo ""
sleep 2
clear

echo $RED"    >>>>> RUNNING VIRUS QUICK SCAN <<<<<"
echo $RED" ----- This might take a few minutes -----"
# Virus quick scan
echo $GREEN""
VIRUSBIN=/home/$USR/Virus-bin
if [ -d $VIRUSBIN ]; then
	rm -fR $VIRUSBIN &>/dev/null
	mkdir $VIRUSBIN &>/dev/null
else
	mkdir $VIRUSBIN &>/dev/null
fi
clamscan -voi --move=$VIRUSBIN /home/$USR/*
echo "DONE!"
echo ""
sleep 2
clear

echo $GREEN"    >>>>> SUCCESS: System is now clean and up-to-date <<<<<"
echo ""
echo $NORM""
pause(){
	read -n1 -rsp $"Press any key to continue or Ctrl+C to exit..."
}
pause
clear
