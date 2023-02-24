//
//  MainHomeTableViewCell.h
//  Prepaid
//
//  Created by Ahmed Shahid on 04/08/2016.
//  Copyright © 2016 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHomeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ResturantLogo;

@property (strong, nonatomic) IBOutlet UILabel *ResturantName;
@property (strong, nonatomic) IBOutlet UILabel *ResturantAddress;
@property (strong, nonatomic) IBOutlet UIButton *addToCartBtn;
@property (strong, nonatomic) IBOutlet UIButton *imageBtn;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;

@end
