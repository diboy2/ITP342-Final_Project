//
//  AvailableDatesTableViewController.m
//  Class_Check_In
//
//  Created by ITP Student on 5/5/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import "AvailableDatesTableViewController.h"
#import "Class_Check_In_Model.h"
#import "CheckedInStudentsTableViewController.h"
@interface AvailableDatesTableViewController ()
@property (strong,nonatomic) Class_Check_In_Model *model;
@end

@implementation AvailableDatesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [Class_Check_In_Model sharedModel];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.model numberOfDates];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"AvailableDateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary * dateDict = [self.model dateAtIndex:indexPath.row];
    NSDate *date = dateDict[@"date"];
    cell.textLabel.text = date;
    
    return cell;
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
    CheckedInStudentsTableViewController *checkedInStudentsVC = (CheckedInStudentsTableViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = self.tableView.indexPathsForSelectedRows[0];
    NSDictionary *dateDict = [self.model dateAtIndex:indexPath.row];
    [checkedInStudentsVC setStudents:dateDict[@"students"]];
    // Pass the selected object to the new view controller.
}


@end
