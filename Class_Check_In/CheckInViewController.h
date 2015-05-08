//
//  CheckInViewController.h
//  Class_Check_In
//
//  Created by ITP Student on 5/5/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^InputCompletionHandler)(NSString *idText, NSString *nameText, NSString *imageText, UIImage *personImage);

@interface CheckInViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(copy, nonatomic) InputCompletionHandler completionHandler;
@end
