//
//  HYPCurrentLocationViewController.m
//  Demo
//
//  Created by Elvis Nunez on 3/17/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "HYPRootViewController.h"
#import "HYPLocationManager.h"

@interface HYPRootViewController () <HYPLocationManagerDelegate>
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) HYPLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end

@implementation HYPRootViewController

- (HYPLocationManager *)locationManager
{
    if (_locationManager) {
        return _locationManager;
    }
    
    _locationManager = [[HYPLocationManager alloc] init];
    _locationManager.delegate = self;
    return _locationManager;
}

- (MKMapView *)mapView
{
    if (_mapView) {
        return _mapView;
    }

    CGRect frame = [[UIScreen mainScreen] bounds];
    _mapView = [[MKMapView alloc] initWithFrame:frame];
    return _mapView;
}

- (void)loadView
{
    [super loadView];
    CGRect frame = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view addSubview:self.mapView];
    self.view = view;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *directionsBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Directions To" style:UIBarButtonItemStyleBordered target:self action:@selector(directionsBarButtonItemPressed)];
    self.navigationItem.rightBarButtonItem = directionsBarButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.locationManager showCurrentLocation];
}

#pragma mark - HYPLocationManagerDelegate

- (void)locationManager:(HYPLocationManager *)locationManager didUpdateCoordinateRegion:(MKCoordinateRegion)coordinateRegion
{
    [locationManager centerMapView:self.mapView usingCoordinate:coordinateRegion.center];
    self.coordinate = coordinateRegion.center;
}

#pragma mark - Actions

- (void)directionsBarButtonItemPressed
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Where do you want to go?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Get directions", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL accepted = (buttonIndex == 1);
    if (accepted) {
        NSString *locationName = [alertView textFieldAtIndex:0].text;
        if (locationName) {
            [self.locationManager showDirectionsToCoordinate:self.coordinate locationName:locationName];
        }
    }
}

@end
