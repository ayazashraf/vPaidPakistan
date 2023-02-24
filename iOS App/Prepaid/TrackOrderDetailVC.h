//
//  TrackOrderDetailVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 19/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackOrderDetailVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *totalBil;
@property (strong, nonatomic) IBOutlet UITableView *trackOrderBillingTableView;
@property (strong, nonatomic) IBOutlet UITableView *trackOrderDetailTableView;

@end
