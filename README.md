# UbuntuUpdater
This simple bash script is intended to automate system update, virus scan, and cleanup utility for Ubuntu 14+ Distro.

This script basically run apt-get update, upgrade and dist-upgrade automatically.
This script also run a virus scan using ClamAV. If ClamAV is not installed, it will try to install and update it.
This script also runs apt-get autoclean and autoremove.


HOW TO SETUP AND USE THIS SCRIPT:

  1. Download UbuntuUpdater to your home directory
      $ git clone https://github.com/greencloud/UbuntuUpdater.git

  2. Open up Terminal and CD to the UbuntuUpdater directory
      $ cd ~/UbuntuUpdater

  3. Make sure setup.sh is executable before running it on your terminal
      $ chmod a+x setup.sh

  4. Run setup.sh on your Terminal as a regular user
      $ ./setup.sh

  5. Once setup is complete, open up a new Terminal and run this command:
      $ systemupdate


It's that simple. Enjoy!
