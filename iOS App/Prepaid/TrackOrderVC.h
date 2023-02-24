//
//  TrackOrderVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 24/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface TrackOrderVC : UIViewController<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    double user_current_location_lat;
    double user_current_location_lng;
}
@property (strong, nonatomic) IBOutlet UITableView *billTableView;
@property (strong, nonatomic) IBOutlet UITableView *trackOrderTableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *drawerBtn;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *orderDetailsTableView;
@property(strong, nonatomic) IBOutlet UILabel *totalBillLabel;
@property (nonatomic,assign) CLLocationCoordinate2D Source;
@property (nonatomic,assign) CLLocationCoordinate2D Destination;
@end
