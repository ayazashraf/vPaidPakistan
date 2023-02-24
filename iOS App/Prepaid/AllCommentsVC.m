//
//  AllCommentsVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 31/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "AllCommentsVC.h"
#import "commentTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface AllCommentsVC ()

@end

@implementation AllCommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITABLEVIEW DATASOURVE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellID = @"commentTableViewCell";
        commentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"commentTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            //6EF0DC
        }
        cell.commentName.text = [[self.commentsArray objectAtIndex:indexPath.row] valueForKey:@"author_name"];
        cell.commentDescription.text = [[self.commentsArray objectAtIndex:indexPath.row] valueForKey:@"text"];
        //
      //  cell.commentImgBtn.tag = indexPath.row;
       // [cell.commentImgBtn addTarget:self action:@selector(commentImgBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.commentImg sd_setImageWithURL:[NSURL URLWithString:[[self.commentsArray  objectAtIndex:indexPath.row] valueForKey:@"profile_photo_url"]] placeholderImage:nil];
        
        
        return cell;
}
#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)doneBtnPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
