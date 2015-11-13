//
//  ViewController.m
//  childApp
//
//  Created by Nattakarn Osborne on 6/2/15.
//  Copyright © 2015 Nattakarn Osborne. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    CLLocationCoordinate2D coordinate = [locations[0] coordinate];
    
    NSString *latitude = [NSString stringWithFormat:@"%.8f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%.8f", coordinate.longitude];

    /*update server*/
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://protected-wildwood-8664.herokuapp.com/users/%@",self.userName.text]]];/*patch location to server*/
    request.HTTPMethod = @"PATCH";
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    NSDictionary *childDict = @{@"utf8": @"✓",
                                @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=",
                                @"user":@{@"username":self.userName.text,
                                          @"current_lat":latitude,
                                          @"current_longitude":longitude},
                                @"commit":@"CreateUser",
                                @"action":@"update",
                                @"controller":@"users"};
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:childDict options:NSJSONWritingPrettyPrinted  error:nil];
    request.HTTPBody = data;
    self.conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (IBAction)submit:(id)sender {
    NSString *userName = self.userName.text;
    NSString *errorText = @"NO";
    NSString *userNameEmpty = @"Please enter userID";
    BOOL textError = NO;
    if(userName.length == 0){
        textError = YES;
        if ([userName length] == 0) {
            textError = YES;
            errorText = [errorText stringByAppendingString:userNameEmpty];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User ID" message:@"Please enter userID" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    /*ask for permission before update*/
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

@end
