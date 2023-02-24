//
//  DrawerVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 22/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@interface DrawerVC : UIViewController<UITableViewDataSource, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *drawerTableVIew;
@property (strong, nonatomic) IBOutlet UIImageView *accountImage;

@end
