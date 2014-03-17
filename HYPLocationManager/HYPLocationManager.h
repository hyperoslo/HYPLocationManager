//
//  HYPLocation.h
//
//  Created by Elvis Nunez on 4/4/13.
//  Copyright (c) 2013 Hyper. All rights reserved.
//

@import CoreLocation;
@import MapKit;

@protocol HYPLocationManagerDelegate;

@interface HYPLocationManager : NSObject
@property (nonatomic, weak) id <HYPLocationManagerDelegate> delegate;
- (void)showCurrentLocation;
- (void)centerCurrentCountryInMapView:(MKMapView *)mapView;
- (void)centerMapView:(MKMapView *)mapView usingCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)showDirectionsToCoordinate:(CLLocationCoordinate2D)coordinate locationName:(NSString *)locationName;
@end

@protocol HYPLocationManagerDelegate <NSObject>
- (void)locationManager:(HYPLocationManager *)locationManager didUpdateCoordinateRegion:(MKCoordinateRegion)coordinateRegion;
@end
