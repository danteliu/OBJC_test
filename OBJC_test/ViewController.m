//
//  ViewController.m
//  OBJC_test
//
//  Created by liu dante on 2021/7/27.
//

#import "ViewController.h"
#import "UITapGestureRecognizer+test.h"
@interface ViewController ()

@end

@implementation ViewController
{
    HDHScrollPlusView *h;
    UILabel *lab;
    NSRange targetRange;
    NSRange puts;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self getAttr];
//    [self HScro];
//    [self createAttr];
    self.view.onClick(^(void){
//        [self showAlert];//测试弹框
        [self test_group];
    });
}
-(void)test_group {/**<  测试gcdgroup  */
    dispatch_group_t downloadGroup = dispatch_group_create();
    for (int i=0; i<10; i++) {
        dispatch_group_enter(downloadGroup);//备注:dispatch_group_enter 与 dispatch_group_leave成对出现
        [self testblock:^{
            NSLog(@"%d---%d",i,i);
            dispatch_group_leave(downloadGroup);
        }];
    }
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}
-(void)testblock:(void (^)(void))c {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        c();
    });
}
-(void)showAlert{
    AAQYAlertView *view=[AAQYAlertView getView:^(UIView * _Nonnull obj) {
        obj.addTo(self.view);
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }];
    view.titles=@[@"确定",@"取消"];
    view.titleLB.str(@"测试");
    view.messageLB.str(@"测试内容");
    [view show];
    
    
    [@"你好" chineseConvertToPinYinFirstLetterWithCompletionBlock:^(NSString * _Nonnull mark) {
        NSLog(@"%@",mark);
    }];
}

-(void)createAttr{/**<  创建富文本 */
//    id attr=AttStr(@"点击了",AttStr(@"协议").linkForLabel);
    lab=Label.addTo(self.view).bgColor(@"white").lines(3).onLink(^(NSString *text){
        Log(text);
    });
    lab.userInteractionEnabled=YES;
    [lab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)]];

    NSAttributedString *plainText;
    NSAttributedString *plainText1;
    NSAttributedString *linkText;
    NSAttributedString *linkText1;
    
    plainText = [[NSMutableAttributedString alloc] initWithString:@"Add label links with UITapGestureRecognizer"
                                                       attributes:nil];
    linkText = [[NSMutableAttributedString alloc] initWithString:@"我们的东西"
                                                      attributes:@{
                                                          NSForegroundColorAttributeName:[UIColor blueColor]
                                                      }];
    plainText1 = [[NSMutableAttributedString alloc] initWithString:@"普通的"
                                                       attributes:nil];
    
    linkText1 = [[NSMutableAttributedString alloc] initWithString:@"乱七八糟"
                                                      attributes:@{
                                                          NSForegroundColorAttributeName:[UIColor blueColor]
                                                      }];
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] init];
    [attrText appendAttributedString:plainText];
    [attrText appendAttributedString:linkText];
    [attrText appendAttributedString:plainText1];
    [attrText appendAttributedString:linkText1];
    
    NSString *str=attrText.string;

    lab.attributedText=attrText;

    // ivar -- keep track of the target range so you can compare in the callback
    targetRange = [str rangeOfString:@"我们的东西"];
    puts = [str rangeOfString:@"乱七八糟"];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(50);
        make.right.offset(-20);
    }];
}
- (void)handleTapOnLabel:(UITapGestureRecognizer *)tapGesture {
    BOOL didTapLink = [tapGesture didTapAttributedTextInLabel:lab inRange:targetRange];
    BOOL isputs = [tapGesture didTapAttributedTextInLabel:lab inRange:puts];
    
    NSLog(@"我们的东西: %d ,乱七八糟 %d", didTapLink,isputs);

}

-(void)HScro{
    h=[HDHScrollPlusView new];
    h.addTo(self.view).bgColor(@"random");
    [h setDire:(ScrollDireH)];
    [h mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 100, 100));
    }];
    
    UIView *obj=View.addTo(h.layoutView).bgColor(@"random");
    [obj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 100, 100));
        make.width.mas_equalTo(1500);
    }];
}

-(void)getAttr{
    UILabel *one=Label.addTo(self.view).lines(0).lineGap(5).bgColor(@"random")
    .onClick(^(void){
        Log(@"你好");
    });
    NSString *str=@"<h1>Demo iOS application built to highlight MVP (Model View Presenter) and Clean Architecture concepts</h1>";
    
    one.str([self showInHTMLString:str]);
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(Insets(100,0,0,0));
    }];
}
-(NSAttributedString*)showInHTMLString:(NSString*)str{/**<  根据HTML字符串显示HTML */
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{
        NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType
    } documentAttributes:nil error:nil];
    return attrStr;
}

@end
