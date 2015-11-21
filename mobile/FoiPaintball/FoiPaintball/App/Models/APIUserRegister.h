//
//  APIUserRegister.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "APIRegister.h"

@interface APIUserRegister : JSONModel
@property (strong, nonatomic) APIRegister *user;
@end
