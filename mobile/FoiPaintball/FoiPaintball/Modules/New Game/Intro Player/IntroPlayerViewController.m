//
//  IntroPlayerViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 22/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "IntroPlayerViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "APIManager.h"
#import "APIJoinGame.h"
#import "GameWireframe.h"

@interface IntroPlayerViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *popView;

@end

@implementation IntroPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popView.alpha = 0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *pinCode = [alertView textFieldAtIndex:0].text;
        NSLog(@"%@",[[alertView textFieldAtIndex:0] text]);
        
        APIJoinGame *joinGame = [APIJoinGame new];
        joinGame.pin = pinCode;
        joinGame.team = self.segmentedControl.selectedSegmentIndex == 0 ? @"a" : @"b";
        
        
        [SVProgressHUD showWithStatus:@""];
        [[APIManager sharedInstance] joinGameWithAPIJoinGame:joinGame success:^(BOOL a) {
            [SVProgressHUD showSuccessWithStatus:@"Joined"];
            self.popView.transform = CGAffineTransformMakeTranslation(0, self.popView.frame.size.height);
            [UIView animateWithDuration:0.8 animations:^{
                
                self.popView.transform = CGAffineTransformIdentity;
                self.popView.alpha = 1;
            }];
        } failure:^(BOOL a ) {
            [SVProgressHUD showErrorWithStatus:@"Failed to join game"];
        }];
        

    }
}

- (IBAction)enterGameButtonClicked:(UIButton *)sender {
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Game pin:"  message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok",nil];
    
    [alertView setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    UITextField* tf = [alertView textFieldAtIndex:0];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    [alertView show];
    
}

- (IBAction)readyButtonClicked:(UIButton *)sender {
    
    [SVProgressHUD showWithStatus:@"Waiting for judge to start the game..."];
    [[APIManager sharedInstance] playerIsReadyWithSuccess:^(BOOL b) {
        [self refreshGame];
    } failure:^(BOOL b) {
        [SVProgressHUD showErrorWithStatus:@"Try again!"];
    }];
}

- (void)refreshGame
{
    [[APIManager sharedInstance] refreshGameWithSuccess:^(BOOL b) {
        if ([APIManager sharedInstance].currentGame.playing) {
            
            [SVProgressHUD showSuccessWithStatus:@"Joined game"];
            
            [GameWireframe presentPlayGameWithNavigationController:self.navigationController];
            
        } else {
            [self refreshGame];
        }
        
        
    } failure:^(BOOL b) {
        [self refreshGame];
    }];
}


@end
