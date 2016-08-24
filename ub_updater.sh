#!/bin/bash

# CHANGE THIS TO YOUR OWN USERNAME (/home/username)
# But if you're gonna be using this updater through the setup.sh script
# then you can leave this line alone
USR=username

clear
# Defined color settings
RED=$(tput setaf 1 && tput bold)
GREEN=$(tput setaf 2 && tput bold)
BLUE=$(tput setaf 6 && tput bold)
NORM=$(tput sgr0)

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
echo $RED"     NOTICE: This script will always run with root priviledges..."
echo ""
echo ""
sleep 5
clear

echo $RED"    >>>>> UPDATE PACKAGES FROM STANDARD REPO <<<<<"
# Update system
echo $GREEN""
TEMP=/home/$USR/.uutf0
LOCK=/var/lib/apt/lists/lock
SEDIR=/etc/selinux
SEENF=/usr/sbin/getenforce
# Make sure system is not locked
if [ -f $LOCK ]; then
	rm -f $LOCK &>/dev/null
fi
if [[ -d $SEDIR && -f $SEENF ]]; then
	if [ -f $TEMP ]; then
		rm -f $TEMP &>/dev/null
	fi
	# If there SELinux and enforcing is 1, set it to 0 temporarily
	if [ $(getenforce) == 'Enforcing' ]; then
		touch $TEMP &>/dev/null
		setenforce 0 &>/dev/null
	fi
fi
apt-get update --fix-missing
apt-get -y upgrade
apt-get -y dist-upgrade
echo "DONE!"
echo ""
sleep 2
clear

echo $RED"    >>>>> Update ClamAV Anti-virus program <<<<<"
echo $RED"          --- THIS MIGHT TAKE A WHILE ----"
# Update Anti-virus
# If there's no anti-virus found, install ClamAV
echo $NORM""
CLAMFILE=/usr/bin/clamscan
CLAMAVLOG=/var/log/clamav/freshclam.log
if [ ! -f $CLAMFILE ]; then
	echo $RED"    !!!! NO ANTI-VIRUS INSTALLED - INSTALLING CLAMAV !!!!"
	echo $NORM""
	sleep 2
	apt-get install -y clamav clamav-daemon
fi
if [[ -f $CLAMFILE && -f $CLAMAVLOG ]]; then
	sleep 2
	freshclam
	tail -10 $CLAMAVLOG
fi
echo $GREEN"DONE!"
echo ""
sleep 5
clear

echo $RED"    >>>>> RUNNING VIRUS QUICK SCAN <<<<<"
echo $RED" ----- This might take a few minutes -----"
# Virus quick scan
echo $GREEN""
VIRUSBIN=/home/$USR/Quarantine-$RANDOM
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

# Set SELinux back into enforced mode if needed
if [[ -d $SEDIR && -f $SEENF && -f $TEMP ]]; then
	rm -f $TEMP &>/dev/null
	setenforce 1 &>/dev/null
fi

echo $GREEN"    >>>>> SUCCESS: System is now clean and up-to-date <<<<<"
echo ""
echo $NORM""
pause() {
	read -n1 -rsp $"Press any key to continue or Ctrl+C to exit..."
}
pause
clear
