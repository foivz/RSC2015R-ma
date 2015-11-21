//
//  MapCreateViewController.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIGame.h"
#import "APIField.h"

@interface MapCreateViewController : UIViewController
@property (strong, nonatomic) APIGame *game;
@property (strong, nonatomic) APIField *field;
@end
