//
//  DetailsViewController.m
//  BookFace
//
//  Created by NEXTAcademy on 11/3/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "DetailsViewController.h"
#import "AppDelegate.h"
#import "User+CoreDataClass.h"
#import "Comment+CoreDataClass.h"
#import "AddCommentTableViewCell.h"


@interface DetailsViewController ()<UITableViewDataSource,AddCommentTabelViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property NSArray *comments;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.moc = [appdelegate persistentContainer].viewContext;
    
    if(self.newBook){
        //display add new book page
        self.nameLabel.text = @"New Book";
    }
    else{
        //show book message and allow add comment
        self.nameLabel.text = self.book.name;
        self.addButton.hidden = YES;
        
        self.commentTableView.dataSource = self;
        
        NSString *detailMessage = @"Read By : ";
        detailMessage = [NSString stringWithFormat:@"%@ %lu \n",detailMessage, self.book.readBy.count];
        
        NSArray<User *> *allReader = [self.book.readBy allObjects];
        for (User *reader in allReader){
            detailMessage = [NSString stringWithFormat:@"%@, %@",detailMessage, reader.name];
        }
        
        self.detailLabel.text = detailMessage;
        
        //show all comment of the book
        self.comments = [self.book.hasComment allObjects];
        
        //add commenet for saved book
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButtonPressed:(id)sender {
    if(self.newBook){
        
        [self.delegate addNewBookWithName:self.nameLabel.text];
    }
}
#pragma mark - comment tableview Datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((indexPath.row < self.comments.count) && self.comments.count != 0){
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookCommentCell"];
    
    cell.textLabel.text = [self.comments objectAtIndex:indexPath.row];
    
        return cell;
    }
    else{
        AddCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addComment"];
        cell.delegate = self;
        
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.comments.count + 1;
}


#pragma mark - addCommentTableCell Delegate
- (void)addComment:(NSString *)str{
    
    
    Comment *newComment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.moc];
    newComment.comment = str;
    
    [self.book addHasCommentObject:newComment];
    
    NSError *error;
    if(![self.moc save:&error]){
        NSLog(@"SaveCommentError : %@", error);
    }
    
    //self.comments = [self.book.hasComment allObjects];
    [self.commentTableView reloadData];
    
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
