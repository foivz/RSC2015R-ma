//
//  PaintBallApp.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "PaintBallApp.h"
#import <UIKit/UIKit.h>
#import "PaintballTabViewController.h"
#import "OnboardingWireframe.h"
#import "GameWireframe.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "APIManager.h"

@interface PaintBallApp() <OnboardingWireframeOutput>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIStoryboard *homeStoryboard;
@property (strong, nonatomic) PaintballTabViewController *paintballTabBarViewController;
@property (strong, nonatomic) OnboardingWireframe *onboardingWireframe;
@property (strong, nonatomic) UIWindow *onboardingWindow;
@property (strong, nonatomic) GameWireframe *gameWireframe;
@end

@implementation PaintBallApp

+ (instancetype)startTheApp
{
    PaintBallApp *app = [self new];
    return app;
}

- (instancetype)init
{
    self = [super init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.onboardingWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.onboardingWireframe = [OnboardingWireframe setUp];
    self.onboardingWireframe.output = self;
    self.onboardingWindow.rootViewController = self.onboardingWireframe.navigationController;
    
    self.paintballTabBarViewController = self.homeStoryboard.instantiateInitialViewController;
    self.window.rootViewController = self.paintballTabBarViewController;
    
    [self showStartingPoint];
    return self;
}

- (UIStoryboard *)homeStoryboard
{
    if (!_homeStoryboard) {
        _homeStoryboard = [UIStoryboard storyboardWithName:@"PaintballTabBar" bundle:nil];
    }
    return _homeStoryboard;
}


- (void)showStartingPoint
{
    
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        
    [[UITableViewCell appearance] setTintColor:[UIColor grayColor]];
   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //keep splash screen and make login
    
    //gamewireframe
    self.gameWireframe = [GameWireframe setUpWithNavigationController:[self.paintballTabBarViewController.viewControllers objectAtIndex:0]];
    
    //[self.window makeKeyAndVisible];
    
    [self.onboardingWindow makeKeyAndVisible];
}

#pragma mark - OnboardinWireframeOutput
- (void)showTabBar
{
    [UIView animateWithDuration:0.5 animations:^{
        self.onboardingWindow.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.window.alpha = 0.5;
        [self.window makeKeyAndVisible];
        
        [self.gameWireframe presentInitialScreen];
        
        [UIView animateWithDuration:0.4 animations:^{
            self.window.alpha = 1;
        }];
    }];
}

@end
