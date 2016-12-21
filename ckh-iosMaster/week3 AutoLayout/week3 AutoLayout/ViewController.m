//
//  ViewController.m
//  week3 AutoLayout
//
//  Created by NEXTAcademy on 11/1/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "ViewController.h"
#import "CustomeTableViewCell.h"
@interface ViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabelView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.profilePic.image = [UIImage imageNamed:@"profilePic"];
    cell.titleTextView.text = @"name";
    cell.descTextView.text = @"desciption";
    
    if (indexPath.row == 1){
        cell.descTextView.text = @"verylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciption";
    }
    else if (indexPath.row == 2){
        cell.titleTextView.text = @"looooooooooooooooooooooooooooooooongname";
        cell.descTextView.text = @"superlongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionsuperlongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionsuperlongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionsuperlongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionsuperlongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciptionverylongdesciption";
    }
    
    
    return cell;
    
}

@end
