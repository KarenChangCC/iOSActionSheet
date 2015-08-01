//
//  CustomActionSheet.m
//  karentest1
//
//  Created by Karen Chang on 2015/5/19.
//  Copyright (c) 2015年 Karen Chang. All rights reserved.
//

#import "CustomActionSheet.h"
#import "CustomActionSheetCell.h"
#import "ActionSheetItem.h"

@interface CustomActionSheet () <UIGestureRecognizerDelegate>
{
    //NSArray *actionData;
    NSString *actionTitle;
}

@end

@implementation CustomActionSheet

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // for Tap Gesture
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(slideOut)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.delegate = self;
    //防止UITapGestureRecognizer阻擋了event的傳遞, 就像Android有consume event的做法
    [tapGestureRecognizer setCancelsTouchesInView:false];
    
    [self slideIn];
}

- (void)viewDidLayoutSubviews {
    [self adjustHeight];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.actionItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ActionSheetCellIdentifier";
    CustomActionSheetCell *cell = (CustomActionSheetCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"CustomActionSheetCell" owner:self options:nil];
        cell = (CustomActionSheetCell*)[cellArray objectAtIndex:0];
    }
    ActionSheetItem *dataDict = [self.actionItems objectAtIndex:indexPath.row];
    cell.actionName.text = dataDict.itemName;
    if(dataDict.itemImage!=nil) cell.actionIcon.image = [UIImage imageNamed:dataDict.itemImage];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.actionView deselectRowAtIndexPath:indexPath animated:YES];
    [self slideOut];
    
    if([self.delegateOfAction respondsToSelector:@selector(actionSelected:)]) {
        ActionSheetItem *dataDict = [self.actionItems objectAtIndex:indexPath.row];
        // return table row index if data have no itmeId
        if(dataDict.itemId!=nil)
            [self.delegateOfAction actionSelected:dataDict.itemId];
        else
            [self.delegateOfAction actionSelected:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    }
}

#pragma mark - Custom Method
- (void)setData:(NSMutableArray*)data {
    self.actionItems = data;
}

-(void)setTitle:(NSString*)title {
    actionTitle = title;
}

- (void)slideIn {
    self.actionView.layer.cornerRadius = 5.0;
    self.actionView.layer.masksToBounds = YES;
    
    // set up an animation for the transition between the views
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    self.view.alpha=1.0f;
    
    [[self.actionView layer] addAnimation:animation forKey:@"TransitionToActionSheet"];
}

- (void)slideOut {
    [UIView beginAnimations:@"removeFromSuperviewWithAnimation" context:nil];
    
    // Set delegate and selector to remove from superview when animation completes
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Move this view to bottom of superview
    CGRect frame = self.actionView.frame;
    frame.origin = CGPointMake(10.0, self.view.bounds.size.height);
    self.actionView.frame = frame;
    
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID isEqualToString:@"removeFromSuperviewWithAnimation"]) {
        [self.view removeFromSuperview];
    }
}

- (void)adjustHeight {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;  //including status bar
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    float tableHeight = self.actionView.rowHeight * [self.actionItems count];
    // Fix the wrong value from UITableView:rowHeight at iOS8
    if (-1 == self.actionView.rowHeight)
        tableHeight = 44 * [self.actionItems count];
    // including TableView header height
    if(actionTitle!=nil) {
        [self setHeader:(screenWidth-20)];
        tableHeight+=42;
    }
    if(tableHeight > screenHeight) tableHeight = screenHeight;
    //[self.actionView setFrame:CGRectMake(self.actionView.frame.origin.x, (screenHeight-tableHeight), (screenWidth-20), tableHeight)]; //xib內TableView有設定Constraints
    [self.actionView setFrame:CGRectMake(10, (screenHeight-tableHeight-10), (screenWidth-20), tableHeight)];    //xib內TableView沒設定Constraints
}

- (void)setHeader:(float)width {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 42)];
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.userInteractionEnabled = NO;
    labelView.text = actionTitle;
    [headerView addSubview:labelView];
    UIView *seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, width, 2)];
    seperatorView.backgroundColor = [UIColor colorWithWhite:224.0/255.0 alpha:1.0];
    [headerView addSubview:seperatorView];
    self.actionView.tableHeaderView = headerView;
}

@end
