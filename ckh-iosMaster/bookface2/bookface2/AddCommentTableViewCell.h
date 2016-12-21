//
//  AddCommentTableViewCell.h
//  BookFace
//
//  Created by NEXTAcademy on 11/4/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddCommentTableViewCell;
@protocol AddCommentTabelViewCellDelegate <NSObject>

- (void)addComment:(NSString *)str;

@end


@interface AddCommentTableViewCell : UITableViewCell
@property (nonatomic,assign) id <AddCommentTabelViewCellDelegate>delegate;

@end
