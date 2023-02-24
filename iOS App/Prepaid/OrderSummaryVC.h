//
//  OrderSummaryVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 18/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSummaryVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *resturantLogo;
@property (strong, nonatomic) IBOutlet UILabel *resturantName;
@property (strong, nonatomic) IBOutlet UILabel *returantAddress;
@property (strong, nonatomic) IBOutlet UILabel *totalBillLabel;
@property (strong, nonatomic) IBOutlet UITableView *orderSummarytableView;
@property (strong, nonatomic) IBOutlet UIButton *continueBtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *drawerBtn;


@end
