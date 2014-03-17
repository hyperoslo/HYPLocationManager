HYPLocationManager
==================

HYPLocationManager is an easy to use interface for CLLocationManager. If you need to get your current coordinates, or show a specific coordinate on a map, or even get directions from your current location to anywhere, we got you covered.

# Headers

``` objc
- (void)showCurrentLocation;
- (void)centerMapView:(MKMapView *)mapView usingCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)showDirectionsToCoordinate:(CLLocationCoordinate2D)coordinate locationName:(NSString *)locationName;
```

# Delegate

Implement the delegate to get updates for your current location.

``` objc
@protocol HYPLocationManagerDelegate <NSObject>
- (void)locationManager:(HYPLocationManager *)locationManager didUpdateCoordinateRegion:(MKCoordinateRegion)coordinateRegion;
@end
```

License
=======

HYPLocationManager is fully open source under the MIT license. Check [LICENSE](https://github.com/hyperoslo/HYPLocationManager/blob/master/LICENSE.md) for details.

Contributions
=============

If there's something you would like to improve please create a friendly and constructive issue, getting your feedback would be awesome. Have a great day.
