//
//  commentTableViewCell.h
//  Prepaid
//
//  Created by Ahmed Shahid on 30/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *commentImg;
@property (strong, nonatomic) IBOutlet UILabel *commentName;
@property (strong, nonatomic) IBOutlet UILabel *commentDescription;
@property (strong, nonatomic) IBOutlet UIButton *commentImgBtn;

@end
