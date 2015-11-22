//
//  CommunicationViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 22/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "CommunicationViewController.h"
#import "CommunicationTableViewCell.h"

@interface CommunicationViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomVIewConstraint;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

@end

@implementation CommunicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.bottomVIewConstraint.constant = 0;
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.bottomVIewConstraint.constant = 90;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunicationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunicationTableViewCell" forIndexPath:indexPath];
    
    return cell;
}


@end
