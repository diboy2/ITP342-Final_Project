//
//  RosterTableViewController.m
//  Class_Check_In
//
//  Created by ITP Student on 4/29/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import "RosterTableViewController.h"
#import "Class_Check_In_Model.h"
#import "RosterInputViewController.h"
@interface RosterTableViewController ()
@property (strong, nonatomic) Class_Check_In_Model *model;
@end

@implementation RosterTableViewController

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
    return [self.model numberInRoster];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"StudentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary * personDict = [self.model personAtRosterIndex:indexPath.row];
    NSString *name = personDict[@"name"];
    NSString *personId = personDict[@"id"];
    cell.textLabel.text = name;
    cell.detailTextLabel.text = personId;
    // Configure the cell...
    
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
    // Pass the selected object to the new view controller.
    RosterInputViewController   *rosterInputVC = segue.destinationViewController;
    rosterInputVC.completionHandler = ^(NSString *idText, NSString *nameText, NSString *passcodeText,NSString *imageText){
        if(idText !=nil){
            NSDictionary *personDict = @{
            @"name":nameText,
            @"id":idText,
            @"passcode":passcodeText,
            @"image":imageText
            };
            
            [self.model insertPerson:personDict atRosterIndex:0];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
}


@end
