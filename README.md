HYPLocationManager
==================

HYPLocationManager is an easy to use interface for CLLocationManager. If you need to get your current coordinates, or show a specific coordinate on a map, or even get directions from your current location to anywhere, we got you covered.

### How to get my current location with **HYPLocationManager**?

``` objc
#pragma mark - Actions

- (IBAction)showMyCurrentLocation
{
    HYPLocationManager *manager = [[HYPLocationManager alloc] init];
    manager.delegate = self;
    [manager showCurrentLocation];
}

#pragma mark - HYPLocationManagerDelegate

- (void)locationManager:(HYPLocationManager *)locationManager didUpdateCoordinateRegion:(MKCoordinateRegion)coordinateRegion
{
    // do something with your location, or show it in a mapView like this
    [locationManager centerMapView:self.mapView usingCoordinate:coordinateRegion.center];
}
```

### How to get directions to Hyper from my current location?

``` objc
HYPLocationManager *manager = [[HYPLocationManager alloc] init];
[manager showDirectionsfromCoordinate:myCoordinate toLocationNamed:@"Maridalsveien 87"];
```

License
=======

HYPLocationManager is fully open source under the MIT license. Check [LICENSE](https://github.com/hyperoslo/HYPLocationManager/blob/master/LICENSE.md) for details.

Contributions
=============

If there's something you would like to improve please create a friendly and constructive issue, getting your feedback would be awesome. Have a great day.
