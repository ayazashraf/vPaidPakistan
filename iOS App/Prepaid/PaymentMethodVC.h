//
//  PaymentMethodVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 25/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentMethodVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *paymentMethodTableView;

@end
