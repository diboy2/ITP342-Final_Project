//
//  DatesInputViewController.h
//  Class_Check_In
//
//  Created by ITP on 4/29/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^InputCompletionHandler)(NSString *dateText);

@interface DatesInputViewController : UIViewController
@property(copy, nonatomic) InputCompletionHandler completionHandler;
@end

