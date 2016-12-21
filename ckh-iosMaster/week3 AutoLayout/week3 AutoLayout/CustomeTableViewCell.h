//
//  CustomeTableViewCell.h
//  week3 AutoLayout
//
//  Created by NEXTAcademy on 11/1/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
@property (weak, nonatomic) IBOutlet UILabel *descTextView;

@end
