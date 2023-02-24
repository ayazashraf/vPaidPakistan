//
//  OrderSummaryCell.h
//  Prepaid
//
//  Created by Ahmed Shahid on 18/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSummaryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *orderItemName;
@property (strong, nonatomic) IBOutlet UILabel *orderQuantityLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderAmount;
@property (strong, nonatomic) IBOutlet UIButton *orderMinusBtn;
@property (strong, nonatomic) IBOutlet UIButton *orderPlusBtn;

@end
