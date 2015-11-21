//
//  LoginViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "LoginViewController.h"
#import "APIManager.h"
#import "APILogin.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)logInButtonClicked:(UIButton *)sender {
    
    APILogin *apiLogin = [APILogin new];
    apiLogin.username = self.usernameTextField.text;
    apiLogin.password = self.passwordTextField.text;
    
    [SVProgressHUD showWithStatus:@"Signing in"];
    
    [[APIManager sharedInstance] logInWithAPILogin:apiLogin withSuccess:^(APILoginResult *apiLoginResult) {
        
        [SVProgressHUD showSuccessWithStatus:@"Signed In"];
        [self.output showTabBar];
        
        [self.passwordTextField resignFirstResponder];
    } failure:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:@"Failed to log in"];
        [self.output showTabBar];
        
        [self.passwordTextField resignFirstResponder];
    }];
    
}


@end
