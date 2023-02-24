//
//  SettingVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 06/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipSetterVC.h"

@interface SettingVC : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *settingsTableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *drawerBtn;
@property (strong, nonatomic) TipSetterVC * tsVC;
@end
