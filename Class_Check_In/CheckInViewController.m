//
//  CheckInViewController.m
//  Class_Check_In
//
//  Created by ITP Student on 5/5/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import "CheckInViewController.h"

@interface CheckInViewController ()
@property (weak, nonatomic) IBOutlet UIButton *checkInImage;
@property(strong, nonatomic) UIImagePickerController *cameraController;
@end

@implementation CheckInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cameraController = [[UIImagePickerController alloc] init];
    
    
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



@end
