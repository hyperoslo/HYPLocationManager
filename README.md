HYPLocationManager
==================

``` objc
- (void)showCurrentLocation;
- (void)centerMapView:(MKMapView *)mapView usingCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)showDirectionsToCoordinate:(CLLocationCoordinate2D)coordinate locationName:(NSString *)locationName;
```

``` objc
@protocol HYPLocationManagerDelegate <NSObject>
- (void)locationManager:(HYPLocationManager *)locationManager didUpdateCoordinateRegion:(MKCoordinateRegion)coordinateRegion;
@end
```
