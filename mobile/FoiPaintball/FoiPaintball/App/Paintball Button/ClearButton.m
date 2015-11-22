//
//  ClearButton.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 22/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "ClearButton.h"

@implementation ClearButton

- (void)awakeFromNib
{
    UIColor *color = [UIColor colorWithRed:251/255. green:129/255. blue:22/255. alpha:1];
    
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    
    [self.titleLabel setFont:[UIFont fontWithName:@"SF-UI-Text-Medium" size:13]];
    [self setTitle:[self.titleLabel.text uppercaseString] forState:UIControlStateNormal];
    
    [self setTitleColor:color forState:UIControlStateNormal];
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.borderWidth = 0.5;
    [self.layer setBorderColor:[color CGColor]];
}

@end
