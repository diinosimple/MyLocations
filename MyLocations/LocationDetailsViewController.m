//
//  LocationDetailsViewController.m
//  MyLocations
//
//  Created by Iino Daisuke on 2014/11/02.
//  Copyright (c) 2014年 Iino Daisuke. All rights reserved.
//

#import "LocationDetailsViewController.h"

@interface LocationDetailsViewController ()

@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end

@implementation LocationDetailsViewController

- (IBAction)done:(id)sender {
    [self closeScreen];
}
- (IBAction)cancel:(id)sender {
    [self closeScreen];
}
- (void)closeScreen {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.descriptionTextView.text = @"";
    self.categoryLabel.text = @"";
    self.latitudeLabel.text = [NSString stringWithFormat: @"%.8f", self.coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat: @"%.8f", self.coordinate.longitude];
    if (self.placemark != nil) {
        self.addressLabel.text = [self stringFromPlacemark:self.placemark];
    } else {
        self.addressLabel.text = @"No Address Found";
    }
    self.dateLabel.text = [self formatDate:[NSDate date]];
}

- (NSString *)stringFromPlacemark:(CLPlacemark *)placemark {
    return [NSString stringWithFormat:@"%@ %@, %@, %@ %@, %@", placemark.subThoroughfare, placemark.thoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode, placemark.country];
}

- (NSString *)formatDate:(NSDate *)theDate {
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return [formatter stringFromDate:theDate];
}

@end
