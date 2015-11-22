//
//  PaintBallButton.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 22/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "PaintBallButton.h"

@implementation PaintBallButton

- (void)awakeFromNib
{
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    
    [self.titleLabel setFont:[UIFont fontWithName:@"SF-UI-Text-Medium" size:13]];
    [self setTitle:[self.titleLabel.text uppercaseString] forState:UIControlStateNormal];
    
    UIColor *color = [UIColor colorWithRed:251/255. green:129/255. blue:22/255. alpha:1];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backgroundColor = color;
}

@end
