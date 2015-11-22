//
//  APILogin.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface APILogin : JSONModel
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@end
