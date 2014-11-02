//
//  FirstViewController.m
//  MyLocations
//
//  Created by Iino Daisuke on 2014/02/15.
//  Copyright (c) 2014年 Iino Daisuke. All rights reserved.
//

#import "CurrentLocationViewController.h"

@interface CurrentLocationViewController ()

@end

@implementation CurrentLocationViewController
{
    CLLocationManager *_locationManager;
    CLLocation *_location;
    BOOL _updatingLocation;
    NSError *_lastLocationError;
    
    CLGeocoder *_geocorder;
    CLPlacemark *_placemark;
    BOOL _performingReverseGeocoding;
    NSError *_lastGeocodingError;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _locationManager = [[CLLocationManager alloc] init];
        _geocorder = [[CLGeocoder alloc] init];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateLabels];
    [self configureGetButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getLocation:(id)sender {
    
    NSLog(@"GetLocation was called!");
    
    if (_updatingLocation) {
        [self stopLocationManager];
    } else {
        _location = nil;
        _lastLocationError = nil;
        _placemark = nil;
        _lastGeocodingError = nil;
        [self startLocationManager];
        
    }
    
    [self updateLabels];
    [self configureGetButton];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError %@", error);
    
    if (error.code == kCLErrorLocationUnknown) {
        return;
    }
    
    [self stopLocationManager];
    _lastLocationError = error;
    
    [self updateLabels];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"didUpdateLocations %@", newLocation);
    
    if ([newLocation.timestamp timeIntervalSinceNow] < -5.0) {
        // The new location was measured more than 5 seconds ago.
        // This means the location was casched.
        // Let`s ignore this value.
        return;
    }
    
    if (newLocation.horizontalAccuracy < 0) {
        // The new location is simply invalid in this case.
        return;
    }
    
    CLLocationDistance distance = MAXFLOAT;
    if (_location != nil) {
        distance = [newLocation distanceFromLocation:_location];
    }
    
    if (_location == nil || _location.horizontalAccuracy >
        newLocation.horizontalAccuracy) {
        _lastLocationError = nil;
        _location = newLocation;
        
        if (newLocation.horizontalAccuracy <= _locationManager.desiredAccuracy) {
            NSLog(@"*** We're done!");
            [self stopLocationManager];
            [self configureGetButton];
        }
        
        if(distance > 0){
            _performingReverseGeocoding = NO;
            
        }

        if (!_performingReverseGeocoding) {
            NSLog(@"*** Going to geocode");
            _performingReverseGeocoding = YES;
            
            [_geocorder reverseGeocodeLocation:_location
                             completionHandler:
             ^(NSArray *placemarks, NSError *error) {
                 NSLog(@"*** Found placemarks: %@, error: %@",placemarks, error);
                 _lastGeocodingError = error;
                 
                 if (error == nil && [placemarks count] > 0) {
                     _placemark = [placemarks lastObject];
                 } else {
                     _placemark = nil;
                 }
                 _performingReverseGeocoding = NO;
                 [self updateLabels];
             }];
        }
    } else if (distance < 1.0) {
        NSTimeInterval timeInterval = [newLocation.timestamp timeIntervalSinceDate:_location.timestamp];
        if (timeInterval > 10) {
            NSLog(@"*** Force done!");
            [self stopLocationManager];
            [self updateLabels];
            [self configureGetButton];
        }
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"Retrieving location is not allowed!");
    }
}

- (void)updateLabels {
    if (_location != nil) {
        self.latitudeLabel.text = [NSString stringWithFormat:
                                    @"%.8f", _location.coordinate.latitude];
        self.longitudeLabel.text = [NSString stringWithFormat:
                                    @"%.8f", _location.coordinate.longitude];
        self.tagButton.hidden = NO;
        self.messageLabel.text = @"";
        
        if (_placemark != nil) {
            self.addressLabel.text = [self stringFromPlacemark:_placemark];
            
        } else if (_performingReverseGeocoding) {
            self.addressLabel.text = @"Searching for Address...";
        } else if (_lastGeocodingError != nil) {
            self.addressLabel.text = @"Error Finding Address";
        } else {
            self.addressLabel.text = @"No Address Found";
        }
        
    } else {
        NSString *statusMessage;
        if (_lastLocationError != nil) {
            if ([_lastLocationError.domain isEqualToString: kCLErrorDomain] &&
                _lastLocationError.code == kCLErrorDenied) {
                statusMessage = @"Location Services Disabled";
            } else {
                statusMessage = @"Error Getting Location";
            }
        } else if (![CLLocationManager locationServicesEnabled]) {
            statusMessage = @"Location Services Disabled";
        } else if (_updatingLocation) {
            statusMessage = @"Searching...";
        } else {
            statusMessage = @"Press the Button to Start";
        }
        self.messageLabel.text = statusMessage;
    }
}

- (NSString *)stringFromPlacemark:(CLPlacemark *)thePlacemark {
    return [NSString stringWithFormat:@"%@ %@\n%@ %@ %@",
            thePlacemark.subThoroughfare,
            thePlacemark.thoroughfare,
            thePlacemark.locality,
            thePlacemark.administrativeArea,
            thePlacemark.postalCode];
}
            

- (void)configureGetButton {
    if (_updatingLocation) {
        [self.getButton setTitle:@"Stop"
                        forState:UIControlStateNormal];
    } else {
        [self.getButton setTitle:@"Get My Location"
                        forState:UIControlStateNormal];
    }
}


- (void)startLocationManager {
    
    NSLog(@"startLocationManager was called!");

    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
    
        [_locationManager startUpdatingLocation];
        _updatingLocation = YES;
        
        [self performSelector:@selector(didTimeOut:) withObject:nil afterDelay:60];
    }
}

- (void)stopLocationManager {
    
    NSLog(@"stopLocationManager was called!");

    if (_updatingLocation) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(didTimeOut:) object:nil];
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        _updatingLocation = NO;
        //_location = nil;
    } }

- (void)didTimeOut:(id)obj {
    NSLog(@"*** Time out");
    if (_location == nil) {
        [self stopLocationManager];
        _lastLocationError = [NSError errorWithDomain:@"MyLocationErrorDomain" code:1 userInfo:nil];
        [self updateLabels];
        [self configureGetButton];
    }
}
@end
