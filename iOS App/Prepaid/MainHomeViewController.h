//
//  MainHomeViewController.h
//  Prepaid
//
//  Created by Ahmed Shahid on 04/08/2016.
//  Copyright © 2016 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UITableView *TableView;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBarVIew;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *drawerBtn;

@end
