//
//  ViewController.m
//  iOSActionSheet
//
//  Created by Karen Chang on 2015/8/1.
//  Copyright (c) 2015年 Karen Chang. All rights reserved.
//

#import "ViewController.h"
#import "ActionSheetItem.h"

@interface ViewController ()

@property (nonatomic) CustomActionSheet *customActionSheet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Custom ActionSheet for iOS";
    // ActionSheet for Create new questions
    self.customActionSheet = [[CustomActionSheet alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)slideActionSheet:(id)sender {
    [self.navigationController.view addSubview:self.customActionSheet.view];
    [self.customActionSheet setData:[self myActionSheetData]];
    self.customActionSheet.delegateOfAction = self;
    [self.customActionSheet viewWillAppear:NO];
}

-(NSMutableArray *) myActionSheetData {
    NSMutableArray *actionItems = [[NSMutableArray alloc] init];
    ActionSheetItem *item1 = [ActionSheetItem new];
    item1.itemId = @"1";
    item1.itemName = @"喵";
    item1.itemImage = @"cat.png";
    [actionItems addObject:item1];
    ActionSheetItem *item2 = [ActionSheetItem new];
    item2.itemId = @"2";
    item2.itemName = @"汪";
    item2.itemImage = @"dog.png";
    [actionItems addObject:item2];
    ActionSheetItem *item3 = [ActionSheetItem new];
    item3.itemId = @"3";
    item3.itemName = @"凹嗚";
    item3.itemImage = @"wolf.png";
    [actionItems addObject:item3];
    return actionItems;
}

#pragma mark - CustomActionSheet
-(void) actionSelected:(NSString*) itemIdOrIndex {
    NSString *message = [NSString stringWithFormat:@"%@%@", @"Hey, you have choosen the item", itemIdOrIndex];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:NSLocalizedString(@"ok", nil)
                                       otherButtonTitles:nil];
    [av show];
}

@end
