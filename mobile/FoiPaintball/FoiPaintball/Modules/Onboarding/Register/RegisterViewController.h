//
//  RegisterViewController.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewControllerOutput <NSObject>
- (void)presentLogInFromRegister;
@end

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) id<RegisterViewControllerOutput> output;
@end
