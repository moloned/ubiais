#!/bin/bash
#
# https://github.com/jvde-github/AIS-catcher
# https://github.com/abcd567a/install-aiscatcher
# https://docs.aiscatcher.org/installation/ubuntu-debian/
#
sudo apt update
sudo apt upgrade
sudo apt install git
#
sudo bash -c "$(wget -O - https://raw.githubusercontent.com/abcd567a/install-aiscatcher/master/install-aiscatcher.sh)"
#
AIS-catcher -L # test installation
#
cc -o usbreset usbreset.c
#
sudo cp ubiais.service /etc/systemd/system
#
sudo cp ubiais-script.sh /usr/local/bin
#
sudo cp aiscatcher.conf /usr/share/aiscatcher
#
sudo systemctl start ubiais.service
sudo systemctl daemon-reload
sudo systemctl enable ubiais.service
sudo systemctl status ubiais.service


