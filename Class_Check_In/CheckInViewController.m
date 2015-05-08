//
//  CheckInViewController.m
//  Class_Check_In
//
//  Created by ITP Student on 5/5/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import "CheckInViewController.h"
#import "Class_Check_In_Model.h"
@interface CheckInViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *checkInImage;
@property(strong, nonatomic) UIImagePickerController *cameraController;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *passcodeTextField;
@property (strong, nonatomic) Class_Check_In_Model *model;
@end

@implementation CheckInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cameraController = [[UIImagePickerController alloc] init];
    _model = [Class_Check_In_Model  sharedModel];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)takePicture:(id)sender {
    if([self checkCameraExistance]){
        self.cameraController.delegate = self;
        self.cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.cameraController animated:YES completion:NULL];
    }
}
- (IBAction)saveButtonTapped:(id)sender {
    if(self.completionHandler){
        NSUInteger arrayIndex = [self.model dateIndexWhereIdEquals:self.idTextField.text];
        if(arrayIndex != NSNotFound){
            NSDictionary *person = [self.model personAtRosterIndex:arrayIndex];
            if([person[@"passcode"] isEqualToString:self.passcodeTextField.text]){
                UIImage *personImage = self.checkInImage.currentBackgroundImage;
                self.completionHandler(person[@"id"],person[@"name"],person[@"image"],personImage);
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong Password"
                                                                message:@"You must enter the right password to save"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                [alert show];
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ID not found"
                                                            message:@"Are you sure you typed the right id?"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    }
}

- (BOOL) checkCameraExistance{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        return YES;
    }
    else{
        return NO;
    }
}

- (IBAction)cancelButtonTapped:(id)sender {
    if(self.completionHandler){
        self.completionHandler(nil,nil,nil,nil);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    [self.checkInImage setBackgroundImage:originalImage forState:UIControlStateNormal];
    // do something with selectedImage and originalImage
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *)
picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}


@end
