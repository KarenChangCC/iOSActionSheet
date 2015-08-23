# How to Use
<ul>
<li>implement CustomActionSheetDelegate</li>
<ul><li>h file</li>
<div><pre><code>#import &lt;UIKit/UIKit.h&gt;
#import CustomActionSheet.h

@interface DemoCustomActionSheet : UIViewController&lt;CustomActionSheetDelegate&gt
@end</code></pre></div>
<li>m file</li>
<div><pre><code>#import DemoCustomActionSheet.h
#import ActionSheetItem.h // the data model of custom actionsheet

@interface DemoCustomActionSheet()
@property(nonatomic) CustomActionSheet *customActionSheet;
@end</code></pre></div>
</ul>
<li>implement the required method  'actionSelected:(NSString*) itemIdOrIndex'</li>
<ul><li>m file</li></ul>
<div><pre><code>-(void) actionSelected:(NSString*) itemIdOrIndex {
    NSString *message = [NSString stringWithFormat:@"%@%@", @"Hey, you have choosen the item", itemIdOrIndex];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:NSLocalizedString(@"ok", nil)
                                       otherButtonTitles:nil];
    [av show];
}</code></pre></div>
<li>make the CustomActionSheet show up</li>
<ul><li>m file</li></ul>
<div><pre><code>- (void)viewDidLoad {
    [super viewDidLoad];
    // initial
    self.customActionSheet = [[CustomActionSheet alloc] init];
}

// action of button to trigger the CustomActionSheet
- (IBAction)slideActionSheet:(id)sender {
    [self.navigationController.view addSubview:self.customActionSheet.view];
    [self.customActionSheet setData:[self myActionSheetData]];
    self.customActionSheet.delegateOfAction = self;
    [self.customActionSheet viewWillAppear:NO];
}</code></pre></div>
</ul>

# How to Customize
If you are interested in how to customize, please refer the article on my blog.<br/>
Article link: <a href="http://piggy-mylifemystyle.blogspot.tw/2015/05/iosactionsheet_31.html">打造所有iOS版本皆適用的ActionSheet</a>
