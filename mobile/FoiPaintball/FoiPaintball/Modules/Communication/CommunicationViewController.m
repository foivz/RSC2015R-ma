//
//  CommunicationViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 22/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "CommunicationViewController.h"
#import "CommunicationTableViewCell.h"
#import "APIManager.h"
#import <AVFoundation/AVFoundation.h>

@interface CommunicationViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomVIewConstraint;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (strong, nonatomic) APIMessage *lastApiMessage;
@property (strong, nonatomic) NSString *lastStringToSpeech;

@end

@implementation CommunicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    self.synthesizer = [[AVSpeechSynthesizer alloc]init];
    
    [self refreshMessages];
}

- (void)refreshMessages
{
    [self refreshA];
    [self refreshB];
}

- (void)refreshA
{
    [[APIManager sharedInstance] getTeamAMessagesWithSuccess:^(BOOL a) {
        [self.tableView reloadData];
        
        [self playLastMessgae];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self refreshA];
        });
    } failure:^(BOOL a) {
        
    }];
}


- (void)refreshB
{
    [[APIManager sharedInstance] getTeamBMessagesWithSuccess:^(BOOL a) {
        [self.tableView reloadData];
        
        [self playLastMessgae];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self refreshB];
        });
    } failure:^(BOOL a) {
        
    }];
}

- (void)playLastMessgae
{
    
    if ([APIManager sharedInstance].myTeam == nil) {
        return;
    }
    
    if ([[APIManager sharedInstance].myTeam isEqualToString:@"a"]) {
        
        APIMessage *apiMessage = [[APIManager sharedInstance].teamAMessages lastObject];
        if ([apiMessage.message isEqualToString:self.lastApiMessage.message] && !apiMessage.message) {
            return;
        }
        
        [self playAudioWithMessage:apiMessage];
        
    } else {
        
        APIMessage *apiMessage = [[APIManager sharedInstance].teamBMessages lastObject];
        if ([apiMessage.message isEqualToString:self.lastApiMessage.message] && !apiMessage.message) {
            return;
        }
        [self playAudioWithMessage:apiMessage];
    }
}

- (void)playAudioWithMessage:(APIMessage *)apiMessage
{
    self.lastApiMessage = apiMessage;
    
    if (!self.lastApiMessage.message && !self.lastApiMessage.sender_name) {
        return;
    }
    
    NSString *stringToSpeech = [NSString stringWithFormat:@"%@ said %@", self.lastApiMessage.sender_name, self.lastApiMessage.message];

    if ([stringToSpeech isEqualToString:self.lastStringToSpeech]) {
        return;
    }
    
    self.lastStringToSpeech = stringToSpeech;
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:stringToSpeech];
    [utterance setRate:0.4f];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    [self.synthesizer speakUtterance:utterance];
    
}

- (IBAction)sendButtonClicked:(UIButton *)sender {
    if (self.messageTextField.text.length > 0) {
        
        //api
        
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            [[APIManager sharedInstance] sendMessageLikeA:self.messageTextField.text];
        } else {
             [[APIManager sharedInstance] sendMessageLikeB:self.messageTextField.text];
        }
        
        
        self.bottomVIewConstraint.constant = 0;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
        
        [self.messageTextField resignFirstResponder];
        self.messageTextField.text = @"";
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.bottomVIewConstraint.constant = 0;
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.bottomVIewConstraint.constant = 170;
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[APIManager sharedInstance].myTeam isEqualToString:@"a"] && self.segmentedControl.selectedSegmentIndex == 0) {
        return [APIManager sharedInstance].teamAMessages.count;
    } else if ([[APIManager sharedInstance].myTeam isEqualToString:@"b"] && self.segmentedControl.selectedSegmentIndex == 1) {
        return [APIManager sharedInstance].teamBMessages.count;
    } else {
        
        if (![[APIManager sharedInstance].user.role isEqualToString:@"player"]) {
            
            if (self.segmentedControl.selectedSegmentIndex == 0) {
                return [APIManager sharedInstance].teamAMessages.count;
            } else {
                return [APIManager sharedInstance].teamBMessages.count;
            }
            
        }
        return 0;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunicationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunicationTableViewCell" forIndexPath:indexPath];
    
    
    APIMessage *message;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        message = [APIManager sharedInstance].teamAMessages[indexPath.row];
        cell.roundedView.backgroundColor = [UIColor colorWithRed:230/255. green:46/255. blue:0/255. alpha:1];
        
    } else {
         message = [APIManager sharedInstance].teamBMessages[indexPath.row];
        
        cell.roundedView.backgroundColor = [UIColor colorWithRed:17/255. green:136/255. blue:247/255. alpha:1];
        
    }
    
    cell.messageLabel.text = message.message;
    cell.sentByLabel.text = [NSString stringWithFormat:@"sent by:%@", message.sender_name];

    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.messageTextField resignFirstResponder];
    self.bottomVIewConstraint.constant = 0;
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
