//
//  PaymentMethodCell.h
//  Prepaid
//
//  Created by Ahmed Shahid on 25/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentMethodCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *paymentImage;
@property (strong, nonatomic) IBOutlet UILabel *paymentName;
@property (strong, nonatomic) IBOutlet UILabel *paymentSubTitle;
@property (strong, nonatomic) IBOutlet UIView *contentViewOfCell;

@end
