//
//  FoodTableViewCell.m
//  MealSet
//
//  Created by NEXTAcademy on 10/26/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "FoodTableViewCell.h"

@implementation FoodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (IBAction)onFoodButtonPressed:(UIButton *)sender {
    [self.delegate foodTabViewCell:self didSelectButton:sender];
    
}

@end
