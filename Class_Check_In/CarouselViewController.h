//
//  CarouselViewController.h
//  Class_Check_In
//
//  Created by Adrian on 5/8/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@interface CarouselViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (strong, nonatomic)NSDictionary *dateDict;
@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@end
