Raspberry Pi Scripts
========

##Introduction 
- These scripts will get the desired conifugration being advertised by the iOS application and set the Raspberry Pi as an iBeacon

##Expected Output
- NOTE: the configuration app should already be advertising the data at this point. 
- When the script first runs, it will scan for Bluetooth 4.0 devices. 
- It will then prompt you to choose and enter one of the MAC addresses 
![SCREENSHOT]()
- After the MAC address is entered, the program will automatically fetch the configuration and set the Pi to advertise asn iBeacon
![SCREENSHOT]()

##Notes 
- The script currently doesnt automaticallty select the MAC address. This is due to come problems with the lescan command. 