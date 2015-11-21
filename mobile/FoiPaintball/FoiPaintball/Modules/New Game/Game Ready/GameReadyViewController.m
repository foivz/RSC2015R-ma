//
//  GameReadyViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "GameReadyViewController.h"
#import "GameReadyTableViewCell.h"
#import "APIManager.h"

@interface GameReadyViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *gameIdLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GameReadyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self refreshPlayers];
    
    self.gameIdLabel.text = [NSString stringWithFormat:@"Gamde id: @ld", (long)[APIManager sharedInstance].currentGame.gameId];
}

- (void)refreshPlayers
{
    [[APIManager sharedInstance] refreshGameWithSuccess:^(BOOL b) {
        [self.tableView reloadData];
        
        [self refreshPlayers];
    } failure:^(BOOL a) {
       
        [self refreshPlayers];
    }];
}


#pragma mark - tableview
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
    GameReadyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameReadyTableViewCell" forIndexPath:indexPath];
    
    APIPlayer *player = nil;
    if (indexPath.section == 0) {
        player = [APIManager sharedInstance].currentGame.team_a.players[indexPath.row];
    } else {
        player = [APIManager sharedInstance].currentGame.team_b.players[indexPath.row];
    }
    
    cell.nameLabel.text = player.name;
    cell.readyImageView.hidden = !player.ready;
    
    return cell;
}

@end
