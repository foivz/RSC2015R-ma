//
//  GameWireframe.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "GameWireframe.h"
#import "APIManager.h"
#import "CreateNewGameViewController.h"
#import "PlayGameViewController.h"
#import "IntroPlayerViewController.h"

@interface GameWireframe()
@property (strong, nonatomic) UINavigationController *navigationCotroller;
@property (strong, nonatomic) UIStoryboard *storyboard;
@end

@implementation GameWireframe

+ (instancetype)setUpWithNavigationController:(UINavigationController *)navigationController
{
    GameWireframe *gameWireFrame = [self new];
    gameWireFrame.navigationCotroller = navigationController;
    gameWireFrame.storyboard = [UIStoryboard storyboardWithName:@"NewGame" bundle:nil];
    
    return gameWireFrame;
}

- (void)presentInitialScreen
{
    if ([[APIManager sharedInstance].user.role isEqualToString:@"player"]) {
        IntroPlayerViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"IntroPlayerViewController"];
        
        [self.navigationCotroller pushViewController:view animated:YES];
    } else {
        //judge intro
        CreateNewGameViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateNewGameViewController"];
        [self.navigationCotroller pushViewController:view animated:NO];
        
    }
}

+ (void)presentPlayGameWithNavigationController:(UINavigationController *)navigationController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NewGame" bundle:nil];
    
    PlayGameViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"PlayGameViewController"];
    
    [navigationController setViewControllers:@[view] animated:YES];
}

@end
