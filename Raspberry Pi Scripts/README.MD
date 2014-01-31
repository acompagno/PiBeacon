Raspberry Pi Scripts
========

##Introduction 
- These scripts will get the desired conifugration being advertised by the iOS application and set the Raspberry Pi as an iBeacon

##Expected Output
- NOTE: the configuration app should already be advertising the data at this point. 
- When the script first runs, it will scan for Bluetooth 4.0 devices. 
- It will then prompt you to choose and enter one of the MAC addresses 
![SCREENSHOT](https://raw.github.com/acompagno/PiBeacon/master/Images/ScriptsScreenshots/1.png?token=4412299__eyJzY29wZSI6IlJhd0Jsb2I6YWNvbXBhZ25vL1BpQmVhY29uL21hc3Rlci9JbWFnZXMvU2NyaXB0c1NjcmVlbnNob3RzLzEucG5nIiwiZXhwaXJlcyI6MTM5MTc5NTM3NX0%3D--ea84625c817e5a1f9513f02564977dddada37e04)
- After the MAC address is entered, the program will automatically fetch the configuration and set the Pi to advertise asn iBeacon
![SCREENSHOT](https://raw.github.com/acompagno/PiBeacon/master/Images/ScriptsScreenshots/2.png?token=4412299__eyJzY29wZSI6IlJhd0Jsb2I6YWNvbXBhZ25vL1BpQmVhY29uL21hc3Rlci9JbWFnZXMvU2NyaXB0c1NjcmVlbnNob3RzLzIucG5nIiwiZXhwaXJlcyI6MTM5MTc5NTQ0Mn0%3D--22eb22600f815aadb568755da432bbdc973895d5)

##Notes 
- The script currently doesnt automaticallty select the MAC address. This is due to come problems with the lescan command. 