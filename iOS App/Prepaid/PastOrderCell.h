//
//  PastOrderCell.h
//  Prepaid
//
//  Created by Ahmed Shahid on 17/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"
@interface PastOrderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ResturantLogo;

@property (strong, nonatomic) IBOutlet UILabel *orderStatus;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UILabel *ResturantName;
@property (strong, nonatomic) IBOutlet ASStarRatingView *ratingView;
@property (strong, nonatomic) IBOutlet UILabel *ResturantAddress;
@end
