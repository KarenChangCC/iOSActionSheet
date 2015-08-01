//
//  ActionSheetItem.h
//  karentest1
//
//  Created by Karen Chang on 2015/5/19.
//  Copyright (c) 2015年 Karen Chang. All rights reserved.
//  Data Model for ActionSheet

#import <Foundation/Foundation.h>

@interface ActionSheetItem : NSObject
@property NSString *itemId;     // identity for ActionSheet Item
@property NSString *itemName;   // display text for Item
@property NSString *itemImage;  // display Image for Item
@end
