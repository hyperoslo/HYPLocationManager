//
//  HYPLocation.m
//
//  Created by Elvis Nunez on 4/4/13.
//  Copyright (c) 2013 Hyper. All rights reserved.
//

#import "HYPLocationManager.h"

#define CUSTOMER_METERS_PER_MILE 1000.0
#define METERS_PER_MILE 200000.0

NSString * const kSetupInfoKeyAccuracy = @"SetupInfoKeyAccuracy";
NSString * const kSetupInfoKeyDistanceFilter = @"SetupInfoKeyDistanceFilter";
NSString * const kSetupInfoKeyTimeout = @"SetupInfoKeyTimeout";

@interface HYPLocationManager () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableDictionary *setupInfo;
@property (nonatomic) CGFloat metersPerMile;
@end

@implementation HYPLocationManager

#pragma mark - Set up methods

- (void)centerMapView:(MKMapView *)mapView usingCoordinate:(CLLocationCoordinate2D)coordinate
{
    CLLocationDistance locationDistance = 1000.0;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate,
                                                                       locationDistance,
                                                                       locationDistance);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:YES];
}

#pragma mark - Location Methods

- (NSMutableDictionary *)setupInfo
{
    if (!_setupInfo) {
        _setupInfo = [NSMutableDictionary dictionary];
        [_setupInfo setObject:@(100.0) forKey:kSetupInfoKeyDistanceFilter];
        [_setupInfo setObject:@(100) forKey:kSetupInfoKeyTimeout];
        [_setupInfo setObject:@(kCLLocationAccuracyHundredMeters) forKey:kSetupInfoKeyAccuracy];
    }
    return _setupInfo;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = [[self.setupInfo objectForKey:kSetupInfoKeyAccuracy] doubleValue];
    }
    return _locationManager;
}

- (void)showCurrentLocation
{
    self.metersPerMile = CUSTOMER_METERS_PER_MILE;

    [self stopUpdatingLocation:NSLocalizedString(@"Starting new location", @"New location")];

    // Start updating location
    [self.locationManager startUpdatingLocation];
    [self performSelector:@selector(stopUpdatingLocation:) withObject:@"Timed Out" afterDelay:[[self.setupInfo objectForKey:kSetupInfoKeyTimeout] doubleValue]];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self stopUpdatingLocation:NSLocalizedString(@"Acquired Location", @"Acquired Location")];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = newLocation.coordinate.latitude;
    zoomLocation.longitude = newLocation.coordinate.longitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, self.metersPerMile, self.metersPerMile);
    
    if ([self.delegate respondsToSelector:@selector(locationManager:didUpdateCoordinateRegion:)]) {
        [self.delegate locationManager:self didUpdateCoordinateRegion:viewRegion];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] != kCLErrorLocationUnknown) {
        [self stopUpdatingLocation:NSLocalizedString(@"Error", nil)];
    }
}

- (void)stopUpdatingLocation:(NSString *)state
{
    [self.locationManager stopUpdatingLocation];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation:) object:nil];
}

#pragma mark - Directions

- (void)showDirectionsToCoordinate:(CLLocationCoordinate2D)coordinate locationName:(NSString *)locationName
{
    Class itemClass = [MKMapItem class];
    if (itemClass && [itemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
        toLocation.name = locationName;
        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                                 forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
    } else {
        NSMutableString *mapURL = [NSMutableString stringWithString:@"http://maps.google.com/maps?"];
        [mapURL appendFormat:@"saddr=Current Location"];
        [mapURL appendFormat:@"&daddr=%f,%f", coordinate.latitude, coordinate.longitude];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[mapURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }    
}

@end
