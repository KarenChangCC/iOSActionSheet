//
//  CustomActionSheetCell.h
//  karentest1
//
//  Created by Karen Chang on 2015/5/19.
//  Copyright (c) 2015年 Karen Chang. All rights reserved.
//  UITableViewCell for CustomActionSheet

#import <UIKit/UIKit.h>

@interface CustomActionSheetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *actionIcon;
@property (weak, nonatomic) IBOutlet UILabel *actionName;
@end
