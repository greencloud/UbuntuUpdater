#!/bin/bash

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
echo $BLUE"    This the setup script Ubuntu Linux System Updater. After this all"
echo $BLUE"    you need to do is type in "
echo ""
echo $NORM"    $ systemupdate"
echo ""
echo $BLUE"    in your Linux terminal and the Updater will take care everything"
echo $BLUE"    for your. It's that easy. Enjoy! :)"
echo ""
echo $BLUE"    Setup on going. Please wait....."
echo ""
echo ""
sleep 6
clear

TRIGGER=systemupdate
APPNAME=UbuntuUpdater
BASHRC=/home/$USER/.bashrc
UPDATER=/home/$USER/$APPNAME/ub_updater.sh
ACTIVE=/home/$USER/.ub_updater.sh

pause(){
	read -n1 -rsp $"Press any key to continue or Ctrl+C to exit..."
}

if [ -f $UPDATER ]; then
	# Make updater hidden and executable
	cp $UPDATER $ACTIVE &>/dev/null
	sed -i '6s/.*/USR='$USER'/' $ACTIVE
	chmod a+x $ACTIVE &>/dev/null
fi

if fgrep -cq "$TRIGGER" $BASHRC; then
	echo ""
	echo $GREEN"  --- YOUR UPDATER IS NOW READY TO USE ---"
	echo ""
	echo $NORM"Open up a new Terminal and then run: $ systemupdate"
	pause
	clear
else
	if [ -f $BASHRC ]; then
	# Append an alias for the updater in the .bashrc file
	echo "alias $TRIGGER='sudo ./.ub_updater.sh'" >> $BASHRC
	else
		touch $BASHRC
		echo "alias $TRIGGER='sudo ./.ub_updater.sh'" >> $BASHRC
	fi
	echo ""
	echo $GREEN"  --- YOUR UPDATER IS NOW READY TO USE ---"
	echo ""
	echo $NORM"Open up a new Terminal and then run: $ systemupdate"
	pause
	clear
fi
