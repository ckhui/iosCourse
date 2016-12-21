//
//  DrinkTableViewCell.m
//  MealSet
//
//  Created by NEXTAcademy on 10/26/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "DrinkTableViewCell.h"

@implementation DrinkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onDrinkButtonPressed:(UIButton *)sender {
    [self.delegate drinkTableViewCell:self disSeleteButton:sender];
    
}
@end
