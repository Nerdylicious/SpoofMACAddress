#!/bin/bash
#Programmer: Irish Medina
#Last Modified: July 24, 2013, 2013
#Purpose: Changes the MAC address of the card

echo -e -n "\nPlease enter an interface (ie. wlan1): "
read INTERFACE

if [[ ! "$INTERFACE" =~ ^[(a-z)|(0-9)]+$ ]]; then
	echo "Error: Input is invalid"
	echo "Exiting ..."
	exit 1
fi

echo -e -n "\nThe current mac address for "$INTERFACE" is: "
ifconfig | grep "$INTERFACE"

sudo service network-manager stop

echo -e -n "\nPlease enter new MAC address: "
read NEW_MAC

if [[ ! "$NEW_MAC" =~ ^[0-9a-zA-Z]{2}:[0-9a-zA-Z]{2}:[0-9a-zA-Z]{2}:[0-9a-zA-Z]{2}:[0-9a-zA-Z]{2}:[0-9a-zA-Z]{2}$ ]]; then
	echo "Error: Input is invalid"
	echo "Exiting ..."
	exit 1
fi

sudo ifconfig "$INTERFACE" down
sudo ifconfig "$INTERFACE" hw ether "$NEW_MAC"
sudo ifconfig "$INTERFACE" up

sudo service network-manager start

echo -e -n "MAC address of $INTERFACE set to $NEW_MAC\n\n"
