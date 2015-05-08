//
//  RosterInputViewController.m
//  Class_Check_In
//
//  Created by ITP on 4/29/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import "RosterInputViewController.h"

@interface RosterInputViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passcodeTextField;
@end

@implementation RosterInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonTapped:(id)sender {
    if(![self checkText:self.idTextField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Id Field Empty"
                                                        message:@"Enter Id"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if(![self checkText:self.nameTextField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name Field Empty"
                                                        message:@"Enter Name"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if(![self checkText:self.passcodeTextField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passcode Field Empty"
                                                        message:@"Enter Passcode"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if(self.completionHandler){
        self.completionHandler(self.idTextField.text,self.nameTextField.text,self.passcodeTextField.text,@"");
    }
}

- (IBAction)cancelButtonTapped:(id)sender {
    if(self.completionHandler){
        self.completionHandler(nil,nil,nil,nil);
    }
}


- (IBAction)imageButtonTapped:(id)sender {
    
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL) checkText:(NSString *)text{
    if([text isEqualToString:@""] || text ==nil){
        return NO;
    }
    
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
