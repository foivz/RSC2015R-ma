//
//  IntroViewController.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroViewControllerDeleagte <NSObject>
- (void)presentRegistration;
- (void)presentLogInAsJudge;
- (void)presentLogInAsPlayer;

@end

@interface IntroViewController : UIViewController
@property (weak, nonatomic) id<IntroViewControllerDeleagte> output;
@end
