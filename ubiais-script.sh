#!/bin/bash
#
hostname -I

#sudo ./usbreset /dev/bus/usb/001/004
SDRreset=$(lsusb | grep DVB-T | awk '{print "sudo ./usbreset /dev/bus/usb/"$2"/"$4}' | sed 's/://') 
echo $SDRreset
$SDRreset
#
#sudo systemctl start ais-catcher.service
#sudo systemctl status ais-catcher.service
#
#AIS-catcher -v 10 -N 8100 -X 9da698ca-e4e2-4cbe-8c39-c42bc60a097e &
#AIS-catcher -v 10 -N 8100 -X 9da698ca-e4e2-4cbe-8c39-c42bc60a097e -go AFC_WIDE on -gr rtlagc on -m 2 -go droop off -m 2 -m 2 &
#
# https://docs.aiscatcher.org/advanced/samplerate/
#
#AIS-catcher -v 10 -N 8100 -X 9da698ca-e4e2-4cbe-8c39-c42bc60a097e -go AFC_WIDE on -gr rtlagc on -m 2 -go droop off -m 2 -m 2 &
#AIS-catcher -v 10 -N 8100 -X 9da698ca-e4e2-4cbe-8c39-c42bc60a097e -go AFC_WIDE on -gr rtlagc on -N REALTIME
AIS-catcher -v 10 -N 8100 -X 9da698ca-e4e2-4cbe-8c39-c42bc60a097e -go AFC_WIDE on -gr rtlagc on 
#
echo ""
cat /usr/share/aiscatcher/aiscatcher.conf
echo ""

hostname
hostname -I

iwlist wlan0 scan | grep Ubotica

echo ""
echo "updated 20 Feb 2025"
echo ""
