//
//  ProfileViewController.m
//  BookFace
//
//  Created by NEXTAcademy on 11/3/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "ProfileViewController.h"
#import "DetailsViewController.h"
#import "AppDelegate.h"

@interface ProfileViewController () <DetailViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UITableView *bookTableView;
@property NSArray *books;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bookTableView.dataSource = self;
    self.bookTableView.delegate = self;
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.moc = [appdelegate persistentContainer].viewContext;
    
    [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
    self.nameLabel.text = self.userProfile.name;
    
    self.books = [self.userProfile.read allObjects];
    
}

- (void)viewDidAppear:(BOOL)animated{
    self.books = [self.userProfile.read allObjects];
    [self.bookTableView reloadData];
}

- (IBAction)onAddBookButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"addBook" sender:self];
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addBook"]){
        DetailsViewController *destination = [segue destinationViewController];
        destination.delegate = self;
        
        destination.newBook = YES;
    }
    else if ([segue.identifier isEqualToString:@"showDetail"]){
        DetailsViewController *destination = [segue destinationViewController];
        destination.delegate = self;
        
        destination.newBook = NO;
        destination.book = (Book *)[self.books objectAtIndex:((NSIndexPath *)sender).row];
    }}

#pragma mark - tableview datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookCell"];
    Book *book = [self.books objectAtIndex:indexPath.row];
    
    cell.textLabel.text = book.name;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.books.count;
}

#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
}

#pragma mark - detailViewController Delegate
- (void)addNewBookWithName:(NSString *)bookName{
    
    Book *bookAddReader;
    
    //search for the book
    NSArray *searchBook = [self loadDataFromEntity:@"Book" withName:bookName];

    
    if(searchBook.count > 0){
        //book exist
        NSLog(@"Book with same name : %lu",(unsigned long)searchBook.count);
        //for(Book *book in searchBook){
        bookAddReader = [searchBook firstObject];
        NSLog(@"Book read by : %lu poeple",(unsigned long)bookAddReader.readBy.count);
        
        
    }else{
        
        
        //if not then add a new book to core data
        
        bookAddReader = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.moc];
        bookAddReader.name = bookName;
    }
    
    //add the book to user
    [self.userProfile addReadObject:bookAddReader];
    
    NSError *error;
    if(![self.moc save:&error]){
        NSLog (@"Insert New Book Error : %@", error);
    }
    
    
}

- (NSArray *) loadDataFromEntity:(NSString *)entity withName:(NSString *)name{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",name];
    
    request.predicate = predicate;
    
    NSError *error = nil;
    
    
    NSArray *result = [[self.moc executeFetchRequest:request error:&error] mutableCopy];
    
    if (error){
        NSLog(@"load team error :%@",error);
    }
    
    return result;
}


@end
