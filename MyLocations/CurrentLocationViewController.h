//
//  FirstViewController.h
//  MyLocations
//
//  Created by Iino Daisuke on 2014/02/15.
//  Copyright (c) 2014年 Iino Daisuke. All rights reserved.
//

@interface CurrentLocationViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *tagButton;
@property (weak, nonatomic) IBOutlet UIButton *getButton;

- (IBAction)getLocation:(id)sender;

@end
