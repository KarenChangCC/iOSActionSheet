//
//  CustomActionSheet.h
//  karentest1
//
//  Created by Karen Chang on 2015/5/19.
//  Copyright (c) 2015年 Karen Chang. All rights reserved.
//
//  Custom ActionSheet created by UITableView

#import <UIKit/UIKit.h>

@class CustomActionSheet;
@protocol CustomActionSheetDelegate <NSObject>
-(void) actionSelected:(NSString*) itemIdOrIndex;
@end

@interface CustomActionSheet : UIViewController<UITableViewDelegate, UITableViewDataSource>
-(void)setData:(NSMutableArray*)data;
-(void)setTitle:(NSString*)title;

@property (weak, nonatomic) IBOutlet UITableView *actionView;
@property (nonatomic,strong) NSMutableArray *actionItems;

@property(nonatomic,weak) id<CustomActionSheetDelegate> delegateOfAction;
@end