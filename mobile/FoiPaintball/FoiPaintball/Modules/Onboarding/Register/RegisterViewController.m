//
//  RegisterViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "RegisterViewController.h"
#import "APIManager.h"
#import <SVProgressHUD/SVProgressHUD.h>



@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNametextField;

@property (weak, nonatomic) IBOutlet UITextField *nameSurnameTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createAccountButtonClicked:(UIButton *)sender {
    
    if (self.passwordTextField.text.length > 0 && self.userNametextField.text.length > 0 && self.nameSurnameTextField.text.length > 0) {
        
        [SVProgressHUD showWithStatus:@"Registering"];
        
        APIRegister *apiRegister = [APIRegister new];
        apiRegister.name = self.nameSurnameTextField.text;
        apiRegister.username = self.userNametextField.text;
        apiRegister.password = self.passwordTextField.text;
        
        [[APIManager sharedInstance] registerWithAPIregister:apiRegister withSuccess:^(BOOL result) {
            [SVProgressHUD showSuccessWithStatus:@"Registered"];
            
            [self.output presentLogInFromRegister];
            
        } failure:^(BOOL result) {
            [SVProgressHUD showErrorWithStatus:@"Registration failed"];
        }];
        
    } else
    {
        [SVProgressHUD showErrorWithStatus:@"Fill all inputs"];
    }
}

@end
