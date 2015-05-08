//
//  CheckedInStudentsTableViewController.m
//  Class_Check_In
//
//  Created by ITP on 4/29/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import "CheckedInStudentsTableViewController.h"
#import "CheckInViewController.h"
#import "Class_Check_In_Model.h"


@interface CheckedInStudentsTableViewController ()
@property(strong, nonatomic) NSMutableArray *students;
@property(strong, nonatomic) Class_Check_In_Model   *model;
@end

@implementation CheckedInStudentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _students = _dateDict[@"students"];
    _model = [Class_Check_In_Model sharedModel];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self numberOfCheckedInStudents];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"checkedInStudentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary * studentDict = [self checkedInStudentAtIndex:indexPath.row];
    NSString *name = studentDict[@"name"];
    cell.textLabel.text = name;
    // Configure the cell...
    
    return cell;
}
- (NSUInteger)numberOfCheckedInStudents{
    return [self.students count];
}

- (NSDictionary *)checkedInStudentAtIndex: (NSUInteger) index{
    return [self.students objectAtIndex:index];
}

- (void) insertCheckedInStudent:(NSDictionary *)student atRosterIndex:(NSUInteger) index{
    NSUInteger numberOfCheckedInStudents = [self numberOfCheckedInStudents];
    if(index <= numberOfCheckedInStudents){
        [self.students
         insertObject:student
         atIndex:index];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CheckInViewController  *checkInVC = segue.destinationViewController;
    checkInVC.completionHandler = ^(NSString *idText, NSString *nameText, NSString *imageText, UIImage *personImage){
        if(idText !=nil){
            NSString *date = self.dateDict[@"date"];
            NSString *dateFolderPath = [self createDateFolder:date];
            NSData *pngData = UIImagePNGRepresentation(personImage);
            NSString *imageFile = [NSString stringWithFormat:@"%@.png",idText];
            NSString *imagePath = [dateFolderPath stringByAppendingPathComponent:imageFile];
            [pngData writeToFile:imagePath atomically:YES];
            NSDictionary *student = @{
            @"id":idText,
            @"name":nameText,
            @"image":imageText
            };
            [self.students insertObject:student atIndex:0];
            [self.model save];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(NSString *)createDateFolder:(NSString *) date{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dateFolder = [NSString stringWithFormat: @"/%@",date];
    NSString *dateFolderPath = [documentsDirectory stringByAppendingPathComponent:dateFolder];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:dateFolderPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dateFolderPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return dateFolderPath;
}

@end
