//
//  OnboardingWireframe.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "OnboardingWireframe.h"
#import "IntroViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"



@interface OnboardingWireframe()<IntroViewControllerDeleagte, RegisterViewControllerOutput, LoginViewControllerOutput>

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIStoryboard *storyboard;

@end

@implementation OnboardingWireframe

+ (instancetype)setUpWithNavigationController:(UINavigationController *)navigationController
{
    OnboardingWireframe *onboardingWireframe = [self new];
    onboardingWireframe.navigationController = navigationController;
    onboardingWireframe.storyboard = [UIStoryboard storyboardWithName:@"Onboarding" bundle:nil];
    
    return onboardingWireframe;
}

+ (instancetype)setUp
{
    OnboardingWireframe *onboardingWireframe = [self new];
    onboardingWireframe.storyboard = [UIStoryboard storyboardWithName:@"Onboarding" bundle:nil];
    onboardingWireframe.navigationController = onboardingWireframe.storyboard.instantiateInitialViewController;
    
    IntroViewController *introViewController = (IntroViewController *)onboardingWireframe.navigationController.topViewController;
    introViewController.output = onboardingWireframe;
    
    return onboardingWireframe;
}

#pragma  mark - IntroViewControllerDeleagte

- (void)presentRegistration
{
    RegisterViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    view.output = self;
    [self.navigationController pushViewController:view animated:YES];
}

- (void)presentLogInAsJudge
{
    [self showTabBar];
}

- (void)presentLogInAsPlayer
{
    LoginViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    view.output = self;
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - RegisterViewControllerOutput
- (void)presentLogInFromRegister
{
    LoginViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    view.output = self;
    [self.navigationController setViewControllers:@[self.navigationController.viewControllers[0], view]];
}

#pragma mark - LoginViewControllerOutput
- (void)showTabBar
{
    [self.output showTabBar];
}


@end
