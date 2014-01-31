Configuration Application
========

##Introduction 
- This application allows you to set the UUID, major, and minor values that are advertised by the iBeacon 

##Resources
- [Core Bluetooth Programming Guide](https://developer.apple.com/library/ios/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/AboutCoreBluetooth/Introduction.html#//apple_ref/doc/uid/TP40013257-CH1-SW1)
- [CoreBluetoothPeripheral by Alastair Tse](https://github.com/liquidx/CoreBluetoothPeripheral)
	- This project really helped me when setting up this application

##How to use the app
- When the app is started up, it will display 2 
![SCREENSHOT](https://raw.github.com/acompagno/PiBeacon/master/Images/AppScreenshots/1.PNG)
- When the desired cpnfigurations are set, press "Send info". This will make an AlertView appear. This means that the device is advertising the selected configuration. At this point, you have to run the scripts on the Raspberry Pi so it can receive the configuration
![SCREENSHOT](https://raw.github.com/acompagno/PiBeacon/master/Images/AppScreenshots/2.PNG)

##Notes 
- Default values 
	- UUID: E2C56DB5-DFFB-48D2-B060-D0F5A71096E0
	- Major: 0 
	- Minor: 0
- Major and Minor limitations
	- The major and minor are represented in the advertisement by a 16 bit integer. This means that their maximum value is 0xFFFF or 65535  
