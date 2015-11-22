//
//  CommunicationTableViewCell.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 22/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "CommunicationTableViewCell.h"

@interface CommunicationTableViewCell()

@end

@implementation CommunicationTableViewCell

- (void)awakeFromNib {

    self.roundedView.layer.cornerRadius = 5.0;
    self.roundedView.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
