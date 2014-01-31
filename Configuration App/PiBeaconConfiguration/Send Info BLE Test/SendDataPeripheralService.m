//
//  PiBeacon Configuration
//  Copyright (c) 2014 ACompagno. All rights reserved.
//

#import "SendDataPeripheralService.h"

@implementation SendDataPeripheralService : NSObject

// Returns YES if Bluetooth 4 LE is supported on this operation system.
+ (BOOL)isBluetoothSupported
{
    return (NSClassFromString(@"CBPeripheralManager") != nil);
}

//initialize the peripheral servive
- (id)init
{
    self = [super init];
    self ? self.peripheral = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil] : nil ;
    return self;
}

//Sets up the service and adds the to the peropheral
- (void)enableService
{
    NSLog(@"(void)enableService");
    
    // If the service is already registered, we need to re-register it again.
    self.service ? [self.peripheral removeService:self.service] : nil ;
    
    
    // Create a BTLE Peripheral Service and set it to be the primary.
    self.service = [[CBMutableService alloc]
                    initWithType:self.serviceUUID primary:YES];
    
    NSString *tempStr = [self.dataToSend stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //Creates the different characteristic that will be broadcasted
    self.characteristicArray = (NSArray*)@[
                                           [[CBMutableCharacteristic alloc]
                                            initWithType:self.characteristicUUIDs[0]
                                            properties:CBCharacteristicPropertyRead
                                            value:[[tempStr substringWithRange:NSMakeRange(0 , 19)]
                                                   dataUsingEncoding:NSUTF8StringEncoding]
                                            permissions:1],
                                           
                                           [[CBMutableCharacteristic alloc]
                                            initWithType:self.characteristicUUIDs[1]
                                            properties:CBCharacteristicPropertyRead
                                            value:[[tempStr substringWithRange:NSMakeRange(19 , 19)]
                                                   dataUsingEncoding:NSUTF8StringEncoding]
                                            permissions:1],
                                           
                                           [[CBMutableCharacteristic alloc]
                                            initWithType:self.characteristicUUIDs[2]
                                            properties:CBCharacteristicPropertyRead
                                            value:[[tempStr substringWithRange:NSMakeRange(38 , 19)]
                                                   dataUsingEncoding:NSUTF8StringEncoding]
                                            permissions:1],
                                           
                                           [[CBMutableCharacteristic alloc]
                                            initWithType:self.characteristicUUIDs[3]
                                            properties:CBCharacteristicPropertyRead
                                            value:[[tempStr substringWithRange:NSMakeRange(57 , tempStr.length - 57)]
                                                   dataUsingEncoding:NSUTF8StringEncoding]
                                            permissions:1]
                                           ];
    
    
    // Assign the characteristics to the service
    self.service.characteristics = self.characteristicArray;
    
    //Add the service to the peripheral
    [self.peripheral addService:self.service];
}

//Removes and disables the service
- (void)disableService
{
    NSLog(@"(void)disableService");
    [self.peripheral removeService:self.service];
    self.service = nil;
    [self stopAdvertising];
}

//Starts advertising
- (void)startAdvertising
{
    NSLog(@"(void)startAdvertising");
    if (self.peripheral.isAdvertising)
    {
        [self.peripheral stopAdvertising];
    }
    
    //Set the advertisememt of the service
    NSDictionary *advertisment = @{CBAdvertisementDataServiceUUIDsKey : @[self.serviceUUID],
                                   CBAdvertisementDataLocalNameKey: self.serviceName};
    //Starts adertising the service
    [self.peripheral startAdvertising:advertisment];
}

//stops
- (void)stopAdvertising
{
    NSLog(@"(void)stopAdvertising");
    [self.peripheral stopAdvertising];
}

- (BOOL)isAdvertising
{
    return [self.peripheral isAdvertising];
}

#pragma mark - CBPeripheralManagerDelegate -

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
{
    NSLog(@"peripheralManager:didReceiveRequest:");
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    NSLog(@"(void)peripheralManager:didAddService:error:");
    // As soon as the service is added, we should start advertising.
    [self startAdvertising];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state)
    {
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"peripheralStateChange: Powered On");
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"peripheralStateChange: Powered Off");
            [self disableService];
            self.serviceRequiresRegistration = YES;
            break;
        case CBPeripheralManagerStateResetting:
            NSLog(@"peripheralStateChange: Resetting");
            self.serviceRequiresRegistration = YES;
            break;
        case CBPeripheralManagerStateUnauthorized:
            NSLog(@"peripheralStateChange: Deauthorized");
            [self disableService];
            self.serviceRequiresRegistration = YES;
            break;
        case CBPeripheralManagerStateUnsupported:
            NSLog(@"peripheralStateChange: Unsupported");
            self.serviceRequiresRegistration = YES;
            break;
        case CBPeripheralManagerStateUnknown:
            NSLog(@"peripheralStateChange: Unknown");
            break;
        default:
            break;
    }
}

- (void)applicationDidEnterBackground
{
    NSLog(@"(void)applicationDidEnterBackground");
    [self stopAdvertising];
}

- (void)applicationWillEnterForeground
{
    NSLog(@"(void)applicationWillEnterForeground:");
}

- (void)sendToSubscribers:(NSData *)data
{
    NSLog(@"(void)sendToSubscribers:");
    if (self.peripheral.state != CBPeripheralManagerStatePoweredOn)
    {
        return ;
    }
}
@end
