//
//  FriendListViewController.m
//  BookFace
//
//  Created by NEXTAcademy on 11/3/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "FriendListViewController.h"
#import "AppDelegate.h"
#import "User+CoreDataClass.h"
#import "ProfileViewController.h"


@interface FriendListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listFriendTableView;
@property NSManagedObjectContext *moc;
@property NSArray *users;

@property User *showUserProfile;
@end

@implementation FriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init
    self.listFriendTableView.dataSource = self;
    self.listFriendTableView.delegate = self;
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.moc = [appdelegate persistentContainer].viewContext;
    
    
    //first time, load data and save to core data
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if(![def objectForKey:@"load data"]){
        NSLog(@"loading Data");
        
        NSString *inputData = [[NSBundle mainBundle] pathForResource:@"users" ofType:@"plist"];
        NSArray *users = [NSArray arrayWithContentsOfFile:inputData];
        
        for (NSString *name in users){
            User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.moc];
            user.name = name;
            if (rand()%10 == 0){
                user.isFriend = YES;
            }
            
            NSError *error;
            if(![self.moc save:&error]){
                NSLog(@"Load data error: %@",error);
            }
        }
        [def setObject:@"Done" forKey:@"load data"];
    }
    
    [self makeFriend];
    
    //search bar at the top
    //sort friend base on number of book recommender
    //filter base on name
    
}

- (void)viewDidAppear:(BOOL)animated{
    //load data from core data
    [self loadUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"showProfile"]){
         ProfileViewController *destination = [segue destinationViewController];
         destination.userProfile = self.showUserProfile;
     }
 }


#pragma mark - TabelViewDatasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    
    User *user = [self.users objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Book :%ld",(long)user.read.count];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.users.count;
}


#pragma mare - tableviewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.showUserProfile = [self.users objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showProfile" sender:self];
    
}

#pragma mark - function
- (void) loadUser{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    
    NSSortDescriptor *sortByXXX = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    
    request.sortDescriptors = @[sortByXXX];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isFriend == YES"];
    
    request.predicate = predicate;

    
    NSError *error = nil;
    
    
    self.users = [[self.moc executeFetchRequest:request error:&error] mutableCopy];
    
    if (!error){
        [self.listFriendTableView reloadData];
    }else{
        NSLog(@"load team error :%@",error);
    }
    
}

- (void) makeFriend{
    
}
@end
