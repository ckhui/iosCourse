//
//  AddFriendTableViewCell.h
//  BookFace
//
//  Created by NEXTAcademy on 11/4/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddFriendTableViewCell;
@protocol AddFriendTableViewCellDelegate <NSObject>

- (void) onAddFriendButtonPressedAtCell:(AddFriendTableViewCell *)cell;

@end

@interface AddFriendTableViewCell : UITableViewCell

@property (nonatomic,assign) id<AddFriendTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end
