#reset the bluetooth dongle
sudo hciconfig hci0 reset

#scan for bluetooth 4.0 devices that are advertising 
#lescan runs infinitely so we run it in the background
sudo hcitool lescan &
#Sleep for 5  seconds in order to allow time for the device to find the proper  the ios device
sleep 5
#Kill lescan which is running in the background
nums=`pgrep -f lescan`
echo "$nums" | while read n; do sudo kill -9 "$n"; done
echo ''
#allows the user to choose the proper mac address from the ones displayed by the lescan  command
echo 'Choose a mac address'
read MACADDRESS
echo $MACADDRESS > mac.temp
echo ''
echo 'Reading data from the iPhone'
#prepy.sh fetches the data from the iOS devices
sh sub/prepy.sh
echo ''
echo 'Parsing the raw data'
#parseadv.py parses the raw data 
python3 sub/parseadv.py > adv.final
echo ''
echo 'Final iBeacon Setup'
#beacon.sh finally sets the raspberry pi to advertise as an ibeacon using
sh sub/beacon.sh
#clean up temp files
rm *.temp