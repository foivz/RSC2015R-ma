//
//  OnboardingWireframe.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OnboardingWireframeOutput <NSObject>
- (void)showTabBar;

@end

@interface OnboardingWireframe : NSObject
+ (instancetype)setUpWithNavigationController:(UINavigationController *)navigationController;
+ (instancetype)setUp;
@property (strong, nonatomic, readonly) UINavigationController *navigationController;
@property (weak, nonatomic) id<OnboardingWireframeOutput> output;
@end
