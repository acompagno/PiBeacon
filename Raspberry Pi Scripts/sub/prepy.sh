#get the mac address entered by the user 
echo 'Loading mac address'
MAC=$(cat mac.temp)
#reset the bluetooth dongle
echo 'Resetting device'
sudo hciconfig hci0 reset

#predefined uuids. 
U1='00007fdd-0000-1000-8000-00805f9b34fb'
U2='0000ae51-0000-1000-8000-00805f9b34fb'
U3='0000e605-0000-1000-8000-00805f9b34fb'
U4='00000773-0000-1000-8000-00805f9b34fb'

echo 'Fetching data from '
echo $MAC
#fetch the data from the ios device 
sudo gatttool -i hci0 -b $MAC -t random --char-read -u $U1 > rawdata.temp
sudo gatttool -i hci0 -b $MAC -t random --char-read -u $U2 >> rawdata.temp
sudo gatttool -i hci0 -b $MAC -t random --char-read -u $U3 >> rawdata.temp
sudo gatttool -i hci0 -b $MAC -t random --char-read -u $U4 >> rawdata.temp