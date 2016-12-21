//
//  ProductCellTableViewCell.h
//  Week2Assesment- ChuaKhangHui
//
//  Created by NEXTAcademy on 10/28/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
