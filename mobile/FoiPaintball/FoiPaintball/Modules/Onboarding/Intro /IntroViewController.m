//
//  IntroViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "IntroViewController.h"
#import "APIManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <CoreLocation/CoreLocation.h>


@interface IntroViewController () <UITextViewDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [APIManager sharedInstance];
    
//    self.locationManager = [CLLocationManager new];
//    self.locationManager.distanceFilter = kCLDistanceFilterNone;
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//        [self.locationManager requestWhenInUseAuthorization];
//    [self.locationManager startUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *pinCode = [alertView textFieldAtIndex:0].text;
        NSLog(@"%@",[[alertView textFieldAtIndex:0] text]);
        
        
        [SVProgressHUD showWithStatus:@"Loging in"];
        [[APIManager sharedInstance] logInWithPinCode:pinCode withSuccess:^(APILoginResult *result) {
            [self.output presentLogInAsJudge];
            [SVProgressHUD showSuccessWithStatus:@"Logged in"];
            
        } failure:^(NSString *error) {
            [SVProgressHUD showErrorWithStatus:@"Failed to log in"];
        }];
    }
}


#pragma mark - action
- (IBAction)loginAsJudgeButtonClicked:(UIButton *)sender {
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Pin code:"  message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Log In",nil];
   

    
    [alertView setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    UITextField* tf = [alertView textFieldAtIndex:0];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    [alertView show];
    

    

}

- (IBAction)signInAsPlayerButtonClicked:(UIButton *)sender {
    [self.output presentLogInAsPlayer];
}


- (IBAction)registerButtonClicked:(UIButton *)sender {
    [self.output presentRegistration];
}


@end
