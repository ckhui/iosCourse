//
//  DrinkTableViewCell.h
//  MealSet
//
//  Created by NEXTAcademy on 10/26/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  DrinkTableViewCell;
@protocol DrinkTableViewCellDelegate <NSObject>

- (void) drinkTableViewCell:(DrinkTableViewCell *)drinkTableViewCell disSeleteButton:(UIButton *)button;


@end
@interface DrinkTableViewCell : UITableViewCell

@property (nonatomic,assign) id <DrinkTableViewCellDelegate> delegate;
@end
