//
//  ViewController.m
//  MealSet
//
//  Created by NEXTAcademy on 10/26/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "MenuViewController.h"
#import "FoodTableViewCell.h"
#import "DrinkTableViewCell.h"

@interface MenuViewController () <UITableViewDelegate,UITableViewDataSource, FoodTableViewCellDelegate,DrinkTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UIImageView *drinkImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
    FoodTableViewCell *foodCell = [tableView dequeueReusableCellWithIdentifier:@"foodCell"];
    
        foodCell.delegate = self;
    
        return foodCell;
    }
    
    else if (indexPath.row == 1){
        DrinkTableViewCell *drinkCell = [tableView dequeueReusableCellWithIdentifier:@"drinkCell"];
        
        drinkCell.delegate = self;
        
        return drinkCell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

#pragma mark - foodtableview delegate

- (void)foodTabViewCell:(FoodTableViewCell *)foodTableViewCell didSelectButton:(UIButton *)button{
    self.foodImageView.image = button.imageView.image;
    
}

#pragma mark - drinktableview delegate

-(void)drinkTableViewCell:(DrinkTableViewCell *)drinkTableViewCell disSeleteButton:(UIButton *)button{
    self.drinkImageView.image = button.imageView.image;
}

@end
