//
//  PiBeacon Configuration
//  Copyright (c) 2014 ACompagno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface SendDataPeripheralService : NSObject <CBPeripheralManagerDelegate>

@property(nonatomic, strong) NSString *serviceName;
@property(nonatomic, strong) CBUUID *serviceUUID;
@property(nonatomic, strong) NSArray *characteristicUUIDs;
@property(nonatomic, strong) CBPeripheralManager *peripheral;
@property(nonatomic, strong) NSArray *characteristicArray;
@property(nonatomic, assign) BOOL serviceRequiresRegistration;
@property(nonatomic, strong) CBMutableService *service;
@property(nonatomic, strong) NSData *pendingData;
@property(nonatomic, strong) NSString *dataToSend;

// Returns YES if Bluetooth 4 LE is supported on this operation system.
+ (BOOL)isBluetoothSupported;

- (void)sendToSubscribers:(NSData *)data;

// Called by the application if it enters the background.
- (void)applicationDidEnterBackground;

// Called by the application if it enters the foregroud.
- (void)applicationWillEnterForeground;

// Allows turning on or off the advertisments.
- (void)startAdvertising;
- (void)stopAdvertising;

// Allows remove and adding a new service.
//This is nessesary when the data being sent is changed
- (void)disableService;
- (void)enableService;

- (BOOL)isAdvertising;

@end