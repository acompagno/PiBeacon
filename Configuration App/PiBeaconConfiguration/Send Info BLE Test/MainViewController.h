//
//  PiBeacon Configuration
//  Copyright (c) 2014 ACompagno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendDataPeripheralService.h"
@interface MainViewController : UIViewController <UITextFieldDelegate , UIPickerViewDataSource , UIPickerViewDelegate , UIAlertViewDelegate>
{
    NSNumber *_major;
    NSNumber *_minor;
    NSString *_uuid;
    NSMutableArray *_uuidList;
}

@property(strong , nonatomic) SendDataPeripheralService *peripheralService;

@end
