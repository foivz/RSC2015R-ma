//
//  CreateNewGameViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "CreateNewGameViewController.h"
#import <ActionSheetPicker_3_0/ActionSheetPicker.h>
#import "MapCreateViewController.h"
#import "APIGame.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "APIManager.h"

@interface CreateNewGameViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *gameNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *captureFlagTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberOfTextField;
@property (weak, nonatomic) IBOutlet UITextField *durationTextField;
@property (weak, nonatomic) IBOutlet UITextField *fieldTextField;
@property (assign, nonatomic) NSInteger fieldId;
@property (assign, nonatomic) NSInteger selecetedField;

@property (strong, nonatomic) NSArray *fields;

@end

@implementation CreateNewGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@"Loading available fields"];
    
    [[APIManager sharedInstance] fieldsWithSuccess:^(NSArray *fields) {
        
        [SVProgressHUD showSuccessWithStatus:@"Fields loaded"];
        self.fields = fields;
        
    } failure:^(NSString *string) {
        [SVProgressHUD showErrorWithStatus:@"eroro loading maps"];
    }];
    
}


#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.captureFlagTextField == textField) {
        
        
        NSArray *colors = [NSArray arrayWithObjects:@"Capture The Flag", @"Elimination", nil];
        [self resignAll];
        
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Game Type"
                                                rows:colors
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               self.captureFlagTextField.text = [selectedValue lowercaseString];
                                               if ([@"Capture The Flag" isEqualToString:selectedValue]) {
                                                   self.captureFlagTextField.text = @"ctf";
                                               }
        
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.navigationController.view];
        
        return NO;
    } else if (self.fieldTextField == textField) {
        
        NSMutableArray *filedsString = [NSMutableArray new];
        for (APIField *apiField in self.fields) {
            [filedsString addObject:apiField.name];
        }
        
        [self resignAll];
        
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Field"
                                                rows:filedsString
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               APIField *field = self.fields[selectedIndex];
                                               self.fieldId = field.field_id;
                                               self.selecetedField = selectedIndex;
                                               
                                               self.fieldTextField.text = selectedValue;
                                               
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.navigationController.view];
        
        return NO;
    }
    
    return YES;
}
- (IBAction)tappedOutside:(UITapGestureRecognizer *)sender {
    
    [self resignAll];
}

- (void)resignAll
{
    [self.gameNameTextField resignFirstResponder];
    [self.captureFlagTextField resignFirstResponder];
    [self.numberOfTextField resignFirstResponder];
    [self.durationTextField resignFirstResponder];
    [self.fieldTextField resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    APIGame *game = [APIGame new];
    
    game.name = self.gameNameTextField.text;
    game.type = self.captureFlagTextField.text;
    game.count = [self.numberOfTextField.text integerValue];
    game.duration = [self.durationTextField.text integerValue];
    game.field_id = self.fieldId;
    
    MapCreateViewController *view = segue.destinationViewController;
    view.game = game;
    view.field = self.fields[self.selecetedField];
}

@end
