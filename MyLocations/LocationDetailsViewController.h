//
//  LocationDetailsViewController.h
//  MyLocations
//
//  Created by Iino Daisuke on 2014/11/02.
//  Copyright (c) 2014年 Iino Daisuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationDetailsViewController : UITableViewController
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) CLPlacemark *placemark;
@end
