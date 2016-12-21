//
//  AddFriendViewController.m
//  BookFace
//
//  Created by NEXTAcademy on 11/3/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "AddFriendViewController.h"
#import "AppDelegate.h"
#import "User+CoreDataClass.h"
#import "AddFriendTableViewCell.h"


@interface AddFriendViewController () <UITableViewDataSource, UITableViewDelegate,AddFriendTableViewCellDelegate>

@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UITableView *addFrinedTableView;
@property NSArray *users;

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init
    self.addFrinedTableView.dataSource = self;
    self.addFrinedTableView.delegate = self;
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.moc = [appdelegate persistentContainer].viewContext;
    
    [self loadUser];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TabelViewDatasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addFriendCell"];
    
    cell.delegate = self;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    User *user = [self.users objectAtIndex:indexPath.row];
    

    cell.nameLabel.text = user.name;

    
    if (user.isFriend){
        [cell setBackgroundColor:[UIColor greenColor]];
        [cell.addButton setTitle:@"Unfriend" forState:UIControlStateNormal];
    }
    else{
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.addButton setTitle:@"Add Friend" forState:UIControlStateNormal];
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.users.count;
}

/*
#pragma mark - TabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddFriendTableViewCell *cell = [tableView
     cellForRowAtIndexPath:indexPath];
    
}
*/

#pragma mark - AddFriendViewController delegate
- (void)onAddFriendButtonPressedAtCell:(AddFriendTableViewCell *)cell{
    
    NSIndexPath *indexPath = [self.addFrinedTableView indexPathForCell:cell];
    
    //update isFriend in core date
    User *selectedUser = [self.users objectAtIndex:indexPath.row];
    selectedUser.isFriend = !selectedUser.isFriend;
    
    NSError *error;
    if(![self.moc save:&error]){
        NSLog(@"Load data error: %@",error);
    }
    
    if (selectedUser.isFriend){
        [cell setBackgroundColor:[UIColor greenColor]];
        [cell.addButton setTitle:@"Unfriend" forState:UIControlStateNormal];
    }
    else{
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.addButton setTitle:@"Add Friend" forState:UIControlStateNormal];
    }
}


#pragma mark - function
- (void) loadUser{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    
    //NSSortDescriptor *sortByXXX = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    //request.sortDescriptors = sortByXXX;
    
    NSError *error = nil;
    
    self.users = [[self.moc executeFetchRequest:request error:&error] mutableCopy];
    
    if (!error){
        [self.addFrinedTableView reloadData];
    }else{
        NSLog(@"load team error :%@",error);
    }
    
}


@end
