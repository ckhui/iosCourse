//
//  FoodTableViewCell.h
//  MealSet
//
//  Created by NEXTAcademy on 10/26/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodTableViewCell;
@protocol  FoodTableViewCellDelegate <NSObject>

- (void) foodTabViewCell:(FoodTableViewCell *)foodTableViewCell didSelectButton:(UIButton *)button;

@end

@interface FoodTableViewCell : UITableViewCell
@property (nonatomic,assign) id <FoodTableViewCellDelegate> delegate;

@end
