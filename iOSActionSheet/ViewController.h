//
//  ViewController.h
//  iOSActionSheet
//
//  Created by Karen Chang on 2015/8/1.
//  Copyright (c) 2015年 Karen Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomActionSheet.h"

@interface ViewController : UIViewController<CustomActionSheetDelegate>
- (IBAction)slideActionSheet:(id)sender;
@end

