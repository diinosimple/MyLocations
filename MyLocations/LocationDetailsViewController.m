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

@end
