//
//  AllCommentsVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 31/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllCommentsVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *doneBtn;
@property (strong, nonatomic) IBOutlet UITableView *commentsTable;
@property (strong, nonatomic) NSArray * commentsArray;
@end
