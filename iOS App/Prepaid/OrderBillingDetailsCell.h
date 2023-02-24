//
//  OrderBillingDetailsCell.h
//  Prepaid
//
//  Created by Ahmed Shahid on 18/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBillingDetailsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *billingDetailsItemImage;
@property (strong, nonatomic) IBOutlet UILabel *billingDetailsItemLabel;
@property (strong, nonatomic) IBOutlet UILabel *billingDetailsItemRecipe;
@property (strong, nonatomic) IBOutlet UILabel *billingDetailsItemQty;
@property (strong, nonatomic) IBOutlet UILabel *billingDetailsItemAmount;

@end
