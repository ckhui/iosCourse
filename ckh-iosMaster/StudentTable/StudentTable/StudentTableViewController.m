//
//  StudentTableViewController.m
//  StudentTable
//
//  Created by NEXTAcademy on 11/2/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "StudentTableViewController.h"
#import "AppDelegate.h"
#import "Student+CoreDataClass.h"
#import "Teacher+CoreDataClass.h"

@interface StudentTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property NSManagedObjectContext *moc;
@property NSArray *students;
@property NSArray *teachers;

@end

@implementation StudentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.moc = [appDelegate persistentContainer].viewContext;
    
    
}

- (void) viewDidAppear:(BOOL)animated{
    [self loadStudents];
    [self loadTeachers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.students.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Student *student = [self.students objectAtIndex:indexPath.row];
    
    cell.textLabel.text = student.name;
    cell.detailTextLabel.text = student.teacher.name; //[ NSString stringWithFormat:@"%d",student.age];
    
    
    return cell;
}

#pragma mark - TextfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *inputString = textField.text;
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.moc];
    
    student.name
    = inputString;
    student.age = arc4random_uniform(100);
    
    int index = arc4random_uniform((int)self.teachers.count);
    student.teacher = self.teachers[index];
    
    
    NSError *error;
    
    if([self.moc save:&error]){
        [self loadStudents];
    }else{
        NSLog(@"%@",error);
    }
    
    return YES;
}

- (void) loadStudents{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Student"];
    
    
    NSSortDescriptor *sortByAge =[[NSSortDescriptor alloc]initWithKey:@"age" ascending:YES];
    
    
    
    NSSortDescriptor *sortByName =[[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    
    request.sortDescriptors = @[sortByName,sortByAge];
    
    NSError *error;
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", @"AS"];
    
    //request.predicate = predicate;
    
    self.students = [[self.moc executeFetchRequest:request error:&error] mutableCopy];
    
    if (error == nil){
        [self.tableView reloadData];
    }else{
        NSLog(@"load student%@",error);
    }
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
