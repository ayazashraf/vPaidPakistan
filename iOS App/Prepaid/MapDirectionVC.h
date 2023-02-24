//
//  MapDirectionVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 03/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapDirectionVC : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *carBtn;
@property (strong, nonatomic) IBOutlet UIButton *walkBtn;
@property (strong, nonatomic) IBOutlet MKMapView *directionMapView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (nonatomic,assign) double lat;
@property (strong, nonatomic) IBOutlet UISwitch *earthViewSwitch;
@property (strong, nonatomic) IBOutlet UIView *earthviewView;
@property (strong, nonatomic) IBOutlet UILabel *timeTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *eathViewLabel;
@property (strong, nonatomic) IBOutlet UILabel *distTextLabel;
@property (nonatomic,assign) double lng;
@end
