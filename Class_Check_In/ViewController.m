//
//  ViewController.m
//  Class_Check_In
//
//  Created by ITP Student on 4/29/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *showCameraButton;

@property (weak, nonatomic) IBOutlet UIButton *showPhotoGalleryButton;
@property (strong, nonatomic) UIImagePickerController * picker;
@property (weak, nonatomic) IBOutlet UIImageView *imageTest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _picker = [[UIImagePickerController alloc] init];
    
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}
- (IBAction)showCamera:(id)sender {
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;

    self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    self.picker.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    self.picker.allowsEditing = NO;
    
    self.picker.delegate = delegate;
    
    [controller presentModalViewController: self.picker animated: YES];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void) imagePickerController: (UIImagePickerController *)picker
 didFinishPickingMediaWithInfo: (NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    // do something with selectedImage and originalImage
    self.imageTest.image = originalImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *)
picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
