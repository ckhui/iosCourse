//
//  AddFriendTableViewCell.m
//  BookFace
//
//  Created by NEXTAcademy on 11/4/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "AddFriendTableViewCell.h"

@interface AddFriendTableViewCell()



@end

@implementation AddFriendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onAddButtonPressed:(id)sender {

    [self.delegate onAddFriendButtonPressedAtCell:self];
}


@end
