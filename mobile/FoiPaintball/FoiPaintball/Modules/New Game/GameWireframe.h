//
//  GameWireframe.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GameWireframe : NSObject
+ (instancetype)setUpWithNavigationController:(UINavigationController *)navigationController;
- (void)presentInitialScreen;
@end
