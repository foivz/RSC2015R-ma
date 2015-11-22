//
//  LoginViewController.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerOutput <NSObject>
- (void)showTabBar;
@end

@interface LoginViewController : UIViewController
@property (weak, nonatomic) id<LoginViewControllerOutput> output;
@end
