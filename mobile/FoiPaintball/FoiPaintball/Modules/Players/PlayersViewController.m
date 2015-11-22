//
//  PlayersViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 22/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "PlayersViewController.h"
#import "APIManager.h"
#import "PlayersTableViewCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface PlayersViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reload];
}

- (void)reload
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self reload];
    });
}

#pragma mark
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? [APIManager sharedInstance].currentGame.team_a.players.count : [APIManager sharedInstance].currentGame.team_b.players.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? @"Team A" : @"Team B";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayersTableViewCell" forIndexPath:indexPath];
    
    APIPlayer *player = nil;
    if (indexPath.section == 0) {
        player = [APIManager sharedInstance].currentGame.team_a.players[indexPath.row];
    } else {
        player = [APIManager sharedInstance].currentGame.team_b.players[indexPath.row];
    }
    
    cell.titleLabel.text = player.name;
    cell.deadImageView.hidden = player.alive;
    
    if (player.alive) {
        cell.statusLabel.text = @"Status : Alive";
        cell.statusLabel.alpha = 1;
        cell.titleLabel.alpha = 1;
    } else {
        cell.statusLabel.text = @"Stats : Dead";
        cell.statusLabel.alpha = 0.7;
        cell.titleLabel.alpha = 0.8;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[APIManager sharedInstance].user.role isEqualToString:@"judge"]) {
        
        [SVProgressHUD showWithStatus:@"Killing player!"];
        
        APIPlayer *player = nil;
       
        if (indexPath.section == 0) {
             player = [APIManager sharedInstance].currentGame.team_a.players[indexPath.row];
        } else {
             player = [APIManager sharedInstance].currentGame.team_b.players[indexPath.row];
        }
        
        
        [[APIManager sharedInstance] killWithUserId:player.playerId withSuccess:^(BOOL a) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"Killed!"];
            });
            
        } failure:^(BOOL a) {
            [SVProgressHUD showErrorWithStatus:@"Failed to kill!"];
        }];
        
    }
}

@end
