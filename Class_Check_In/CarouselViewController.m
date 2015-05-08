//
//  CarouselViewController.m
//  Class_Check_In
//
//  Created by Adrian on 5/8/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import "CarouselViewController.h"

@interface CarouselViewController ()
@property (strong, nonatomic) NSMutableArray *students;
@end

@implementation CarouselViewController

-(void)awakeFromNib{
    
    
}
- (void) dealloc
{
    self.carousel.delegate = nil;
    self.carousel.dataSource = nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.students = self.dateDict[@"students"];
    self.carousel.type = iCarouselTypeTimeMachine;
    
    // Do any additional setup after loading the view.
}
- (void)viewDidUnload{
    [super viewDidUnload];
    self.carousel = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 
#pragma mark iCarousel methods
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    self.students = self.dateDict[@"students"];
    return [self.students count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *nameLabel = nil;
    UILabel *idLabel = nil;
    NSString *dateFolderPath = [self getDateFolder:self.dateDict[@"date"]];
    NSString *imageFile = [NSString stringWithFormat:@"%@.png",self.students[index][@"id"]];
    NSString *imagePath = [dateFolderPath stringByAppendingPathComponent:imageFile];    //create new view if no view is available for recycling
    
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 400.0f)];
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 300.0f, 300.0f)];
        imageView.image = [UIImage imageWithContentsOfFile:imagePath];
        view.contentMode = UIViewContentModeCenter;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,20)];
        idLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,0,200,20)];
        idLabel.textAlignment = NSTextAlignmentRight;
        [view addSubview:idLabel];
        [view addSubview:nameLabel];
        [view addSubview:imageView];
        
    }
    else
    {
        //get a reference to the label in the recycled view
        nameLabel = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    nameLabel.text = self.students[index][@"name"];
    idLabel.text = self.students[index][@"id"];
    return view;
}

-(NSString *)getDateFolder:(NSString *) date{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dateFolder = [NSString stringWithFormat: @"%@",date];
    NSString *dateFolderPath = [documentsDirectory stringByAppendingPathComponent:dateFolder];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:dateFolderPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dateFolderPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return dateFolderPath;
}

@end
