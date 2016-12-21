//
//  AddCommentTableViewCell.m
//  BookFace
//
//  Created by NEXTAcademy on 11/4/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "AddCommentTableViewCell.h"

@interface AddCommentTableViewCell()
@property (weak, nonatomic) IBOutlet UITextView *textBox;

@end

@implementation AddCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onCommentButonPressed:(id)sender {
    [self.delegate addComment:self.textBox.text];
}
@end
