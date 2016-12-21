//
//  TeacherTableViewController.m
//  StudentTable
//
//  Created by NEXTAcademy on 11/3/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "TeacherTableViewController.h"
#import "AppDelegate.h"
#import "Teacher+CoreDataClass.h"

@interface TeacherTableViewController () <UITextFieldDelegate>

@property NSArray *teachers;
@property NSManagedObjectContext *moc;

@end

@implementation TeacherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    self.moc = [appdelegate persistentContainer].viewContext;
    
}

- (void) viewDidAppear:(BOOL)animated{
    [self loadTeachers];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.teachers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Teacher *teacher = self.teachers[indexPath.row];
    cell.textLabel.text = teacher.name;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", teacher.students.count];
    
    return cell;
}

#pragma  mark - uitextview delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *inputString = textField.text;
    
    Teacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.moc];
    teacher.name = inputString;
    
    NSError *error;
    if([self.moc save:&error]){
        [self loadTeachers];
    }else{
        NSLog(@" erorr %@",error);
    }
    
    return YES;
}

- (void) loadTeachers{
    NSFetchRequest *request = [[ NSFetchRequest alloc]initWithEntityName:@"Teacher"];
    NSError *error;
    
    self.teachers = [[self.moc executeFetchRequest:request error:&error] mutableCopy];
    if(error == nil){
        [self.tableView reloadData];
    } else{
        NSLog(@"load error : %@",error);
    }
}

@end
