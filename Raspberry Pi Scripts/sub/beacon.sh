#set up bluetooth 
echo 'Setting up bluetooth device'
#Open and initialize HCI device
sudo hciconfig hci0 up
#Enable LE advertising | 0 - Connectable undirected advertising (default)
sudo hciconfig hci0 leadv 3
#Disable scan
sudo hciconfig hci0 noscan


#get advertisment data from the adv.final file 
echo 'Fetching advertisement data'
#adv.temp file contains only the advertisement data
ADV=$(cat adv.final)

#set the adverisement data. The device is now an iBeacon
echo 'Setting advertisement data'
#set the advertisement data of the bluetooth device 
sudo hcitool -i hci0 cmd 0x08 0x008 $ADV

#done
echo 'Now broadcating as an iBeacon!'