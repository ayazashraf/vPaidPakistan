//
//  PastOrdersCell.h
//  Prepaid
//
//  Created by Ahmed Shahid on 18/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"
@interface PastOrdersCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *orderResturantImg;
@property (strong, nonatomic) IBOutlet UILabel *orderResturantNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderResturantDateAndTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderResturantAmount;
@property (strong, nonatomic) IBOutlet ASStarRatingView *orderResturantRatingView;

@end
