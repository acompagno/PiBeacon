//
//  PiBeacon Configuration
//  Copyright (c) 2014 ACompagno. All rights reserved.
//

#import "MainViewController.h"
#import "Utils.h"
#import "SendDataPeripheralService.h"

#define totalWidth ((CGFloat) self.view.bounds.size.width)
#define totalHeight ((CGFloat) self.view.bounds.size.height)
#define isiOS7 ((BOOL) [[Utils alloc] sysVersionGreaterThanOrEqualTo:@"7.0"])
#define navHeight ((int) [[Utils alloc] getNavBarHeight:self.navigationController.navigationBar.frame.size.height withStatusbar:[UIApplication sharedApplication].statusBarFrame.size.height])

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"PiBeacon Configuration"];
    
    //Initialize and set up the peripheral service
    self.peripheralService = [[SendDataPeripheralService alloc] init];
    self.peripheralService.serviceName = @"iBeaconConfiguration";
    self.peripheralService.serviceUUID = [CBUUID UUIDWithString:@"776e"];
    self.peripheralService.characteristicUUIDs = (NSArray*)@[[CBUUID UUIDWithString:@"7fdd"],
                                                             [CBUUID UUIDWithString:@"ae51"],
                                                             [CBUUID UUIDWithString:@"e605"],
                                                             [CBUUID UUIDWithString:@"0773"]];
    
    //initialize variables with their default values
    _major = [NSNumber numberWithInt:0];
    _minor = [NSNumber numberWithInt:0];
    _uuid = @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0";
    
    //hold the different options for the uuids avaliable in the UIPickerView
    _uuidList = (NSMutableArray*)@[@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0",
                                   @"b2b23d28-fcb7-4b31-aaf9-72abdb5edc5a",
                                   @"ce58989e-1655-4bf5-bae3-261d0564f91b",
                                   @"2085165d-001a-40ca-bf13-24fb0e015f9d",
                                   @"250d4d93-0d1b-4cc1-b334-19e4d682dd29",
                                   @"487d9a1d-1f99-4ef5-820e-c649611ad91e",
                                   @"121848a1-e1fd-4816-8263-1be3fafa2846",
                                   @"b91c7bbc-d758-4982-9207-b4595d08a12c",
                                   @"e592b8c2-48f3-4225-a9da-50fe387fa631",
                                   @"de8fab81-e843-4959-9fd9-d21b1b7df84d",
                                   @"8af970d1-9601-42f5-9254-9aa3400196f8"];
    
    //Button will be used to send the data to the bluetooth device
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //set up the button
    if (sendButton)
    {
        [sendButton setTitle:@"Send Info" forState:UIControlStateNormal];
        sendButton.tag = 1;
        sendButton.frame = CGRectMake(10 , navHeight + 5, 100, 40);
        [sendButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sendButton];
    }
    //Label that says "Major"
    UILabel *majorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 , navHeight + 5 + 40 , totalWidth - 40 , 40)];
    if (majorLabel)
    {
        majorLabel.text = @"Major";
        [self.view addSubview:majorLabel];
    }
    //Text field to enter the value of the major
    UITextField *majorInput = [[UITextField alloc] initWithFrame:CGRectMake(20 , navHeight + 5 + 40 * 2 , totalWidth - 40 , 40)];
    if (majorInput)
    {
        majorInput.keyboardType = UIKeyboardTypeNumberPad;
        majorInput.borderStyle = UITextBorderStyleBezel;
        majorInput.placeholder = @"Enter Major";
        majorInput.delegate = self;
        majorInput.tag = 5;
        [self.view addSubview:majorInput];
    }
    //Label that says "Minor"
    UILabel *minorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 , navHeight + 5 + 40 * 3, totalWidth - 40 , 40)];
    if (minorLabel)
    {
        minorLabel.text = @"Minor";
        [self.view addSubview:minorLabel];
    }
    //Text field to enter the value of the minor
    UITextField *minorInput = [[UITextField alloc] initWithFrame:CGRectMake(20 , navHeight + 5 + 40 * 4 , totalWidth - 40 , 40)];
    if (minorInput)
    {
        minorInput.keyboardType = UIKeyboardTypeNumberPad;
        minorInput.borderStyle = UITextBorderStyleBezel;
        minorInput.placeholder = @"Enter Minor";
        minorInput.delegate = self;
        minorInput.tag = 6;
        [self.view addSubview:minorInput];
    }
    //Label that says "UUID"
    UILabel *uuidLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 , navHeight + 5 + 40 * 5, totalWidth - 40 , 40)];
    if (uuidLabel)
    {
        uuidLabel.text = @"UUID";
        [self.view addSubview:uuidLabel];
    }
    //Picker that allows us to choose between different UUID's
    UIPickerView *uuidPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(20 , totalHeight - 200, totalWidth - 40 , 40)];
    //Set up the picker
    if (uuidPicker)
    {
        uuidPicker.dataSource = self;
        uuidPicker.delegate = self;
        uuidPicker.hidden = YES;
        uuidPicker.tag = 10;
        [self.view addSubview:uuidPicker];
    }
    //Button that shows the picker
    UIButton *selectUUIDButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //Set up the button
    if (selectUUIDButton)
    {
        [selectUUIDButton setTitle:@"Select UUID" forState:UIControlStateNormal];
        selectUUIDButton.tag = 2;
        selectUUIDButton.frame = CGRectMake(10 ,  navHeight + 5 + 40 * 6 , 100, 40);
        [selectUUIDButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectUUIDButton];
    }
}

//Method called when the button are pressed
- (void)buttonPressed:(id)sender
{
    //get the button from the sender
    UIButton *button = (UIButton *)sender;
    //if the tag == 1 , the "Send Info" button was clicked
    if (button.tag == 1)
    {
        NSLog(@"Advertisement data to be sent \n%@" , [self generateBeaconPackagewithMajor:_major withMinor:_minor withID:[NSString stringWithString:_uuid]]);
        self.peripheralService.dataToSend = [self generateBeaconPackagewithMajor:_major withMinor:_minor withID:[NSString stringWithString:_uuid]];
        [self.peripheralService enableService];
        UIAlertView *advertisingAlert =[[UIAlertView alloc] initWithTitle:@"Advertising iBeacon Configuration"
                                                                  message:[NSString stringWithFormat:@"UUID: %@\nMajor: %@\nMinor: %@",
                                                                           _uuid, _major, _minor]
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                        otherButtonTitles:@"Done", nil];
        [advertisingAlert show];
        
    }
    //if the tag equals 2, the uuid picker button was clicked
    else if (button.tag == 2)
    {
        //get the picker from it tag
        UIPickerView *picker = (UIPickerView *)[self.view viewWithTag:10];
        //
        picker.hidden = !(picker.hidden);
        //hide keyboard
        [self.view endEditing:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)generateBeaconPackagewithMajor:(NSNumber*) major  withMinor:(NSNumber*) minor  withID:(NSString*)uuid
{
    //Apple's fixed iBeacon advertising prefix
    NSString *advertisingPrefix = @"1e 02 01 1a 1a ff 4c 00 02 15";
    
    //iBeacon profile uuid. Possibly dependent on which site the ibeacon will be put into
    NSString *uuidString = [self formatUUID:uuid];
    
    //Max value of major and minor should be 65535(0xFFFF) (16 bits / 2 bytes)
    //Convert major to hex
    NSMutableString *majorString =[NSMutableString stringWithFormat:@"%04lx", (unsigned long)[major unsignedIntegerValue]];
    [majorString insertString:@" " atIndex:2];
    
    //Convert minor to hex
    NSMutableString *minorString =[NSMutableString stringWithFormat:@"%04lx", (unsigned long)[minor unsignedIntegerValue]];
    [minorString insertString:@" " atIndex:2];
    
    //The 2's complement of the calibrated Tx Power
    NSString *powerString = @"c5";
    
    //Create the package by concatenating all the strings
    NSString *package = [NSString stringWithFormat:@"%@ %@ %@ %@ %@" ,
                         advertisingPrefix,
                         uuidString,
                         majorString,
                         minorString,
                         powerString];
    return package;
}

- (NSString*)formatUUID:(NSString*)uuid
{
    NSMutableString *uuidFormatted = [NSMutableString stringWithString:[[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""]] ;
    for (int i = 2 ; i < uuidFormatted.length ; i+=3)
    {
        [uuidFormatted insertString:@" " atIndex:i];
    }
    return uuidFormatted;
}

#pragma mark - Text Field Delegate -

/************************************************************************************
 *Delegate Methods for the textfields                                               *
 *All of these just make sure that the value gets stored int he varValues dictionary*
 ************************************************************************************/

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    newString.length > 0 ? [self updateVals:newString withTag:textField.tag isFieldEmpty:NO] : [self updateVals:newString withTag:textField.tag isFieldEmpty:YES];
    
    return YES;
}

- (void)updateVals:(NSString*)newVal withTag:(int)tag isFieldEmpty:(BOOL)empty
{
    NSNumber *tmp = empty ? 0 : [NSNumber numberWithInteger:[newVal integerValue]];
    if (tag == 5)
        _major = tmp;
    else if (tag == 6)
        _minor = tmp;
}

#pragma mark - UIPicker Delegate -

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_uuidList count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_uuidList objectAtIndex: row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _uuid = [_uuidList objectAtIndex: row];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UiAlertView Delegate -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.peripheralService stopAdvertising];
    [self.peripheralService disableService];
}

@end
