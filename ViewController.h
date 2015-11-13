//
//  ViewController.h
//  childApp
//
//  Created by Nattakarn Osborne on 6/2/15.
//  Copyright © 2015 Nattakarn Osborne. All rights reserved.
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) NSURLConnection *conn;


@property (strong, nonatomic) IBOutlet UITextField *userName;

@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;

- (IBAction)submit:(id)sender;

@end

