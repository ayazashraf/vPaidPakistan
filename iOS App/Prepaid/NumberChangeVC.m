//
//  NumberChangeVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 15/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "NumberChangeVC.h"
#import<CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
@interface NumberChangeVC ()

@end

@implementation NumberChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.oldNumberTextField becomeFirstResponder];
    CTTelephonyNetworkInfo *network_Info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = network_Info.subscriberCellularProvider;
    
    NSLog(@"country code is: %@", carrier.mobileNetworkCode);
    
    //will return the actual country code
    NSLog(@"ISO country code is: %@", carrier.isoCountryCode);
    
    self.oldNumberTextField.text = carrier.mobileCountryCode;
    self.newwNumberTextField.text = carrier.isoCountryCode;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
