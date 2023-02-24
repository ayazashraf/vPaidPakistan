//
//  MenuAndDetailVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 15/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>
#import "ASStarRatingView.h"
#import "ImageLargerVC.h"
#import "CommentLargerVC.h"
#import "MenuDetailLargerVC.h"

@interface MenuAndDetailVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MKMapViewDelegate, UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
@property (strong, nonatomic) IBOutlet UITableView *commentsTableView;
@property (strong, nonatomic) IBOutlet UIButton *pastOrderBtn;
@property (strong, nonatomic) IBOutlet UIButton *informationBtn;
@property (strong, nonatomic) IBOutlet UIView *resturantInfoView;
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) IBOutlet MKMapView *resturantMapView;
@property (strong, nonatomic) IBOutlet UITextView *resturantDetails;
@property (strong, nonatomic) IBOutlet UISearchBar *menuSearchBar;
@property (strong, nonatomic) IBOutlet UIButton *websiteBtn;
@property (strong, nonatomic) IBOutlet UIButton *callBtn;
@property (strong, nonatomic) IBOutlet ASStarRatingView *ratingStarsView;
@property (strong, nonatomic) IBOutlet UILabel *openCloseStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UIButton *directionsBtn;
@property (strong, nonatomic) IBOutlet UILabel *phNumLabel;
@property (strong, nonatomic) IBOutlet UIImageView *resturant_cover;
@property (strong, nonatomic) IBOutlet UICollectionView *resturantInsideImageCollectionView;
@property (strong, nonatomic) ImageLargerVC * imageLargerVC;//CommentLargerVC
@property (strong, nonatomic) CommentLargerVC * commentLargerVC;//
@property (strong, nonatomic) NSString * title_of_resturant;
@property (strong, nonatomic) NSDictionary * placesDetails;
@property (strong, nonatomic) UIImage * resuturantImage;
@property (strong, nonatomic) MenuDetailLargerVC * menuDetailLargerVC;
@property (strong, nonatomic) UIView * tableViewHeaderView;


@property(strong, nonatomic)NSString * Place_id;
@end
