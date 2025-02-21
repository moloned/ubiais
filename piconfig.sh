#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt install git

sudo apt install rpi-connect-lite

loginctl enable-linger

rpi-connect on
rpi-connect signin

git clone git@github.com:moloned/ubiais.git
