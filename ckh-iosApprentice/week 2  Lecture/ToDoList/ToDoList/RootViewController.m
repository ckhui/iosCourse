//
//  ViewController.m
//  ToDoList
//
//  Created by NEXTAcademy on 10/24/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *tasks;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray *colors;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tasks= [[NSMutableArray alloc] initWithObjects:@"Build Billion Dollor Apps", @"Los App in litigation battle with Facebook", @"Build new app", @"Take Over Next Academy", @"more...", nil];
    
    self.colors = [[NSMutableArray alloc] initWithObjects:[UIColor greenColor], [UIColor blueColor], [UIColor redColor], [UIColor orangeColor],[UIColor purpleColor], nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [self.tasks objectAtIndex:indexPath.row];
    cell.backgroundColor = [self.colors objectAtIndex:(indexPath.row % self.colors.count)];
    return cell;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tasks.count;
}

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
*/
- (IBAction)onAddButtonPressed:(id)sender {
    NSString *newTask = self.textField.text;
    
    [self.tasks addObject:newTask];
    self.textField.textContentType = @"";
    [self.textField resignFirstResponder];
    
    [self.colors addObject:[UIColor clearColor]];
    
    [self.tableView reloadData];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat red = 0;//arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = 0;//arc4random_uniform(255) / 255.0;
    
    UIColor *color =[UIColor colorWithRed:(red) green:green blue:blue alpha:1];
    
    [self.colors replaceObjectAtIndex:(indexPath.row % self.colors.count) withObject:color];

    [self.tableView reloadData];
}

@end
