//
//  ViewController.m
//  OBJC_test
//
//  Created by liu dante on 2021/7/27.
//


#import "OBJC_test-Swift.h"
#import "SaveInfoVC.h"

#import "ViewController.h"
#import "WQPMDViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    BaseHScrollview *h;
    SDCycleScrollView *cycleScrollView;
    UILabel *lab;
    NSRange targetRange;
    NSRange puts;
}
-(void)viewWillAppear:(BOOL)animated{
    [cycleScrollView adjustWhenControllerViewWillAppera];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.hbd_barHidden=YES;
    
    self.hbd_barTintColor = Color(@"white,1");
    NSString *str = [@"你好" jk_encryptedWithAESUsingKey:@"zhyq_20001234567" andIV:@"0123456789abcdef".jk_base64DecodedData];
    Log(str);
    Log([str jk_decryptedWithAESUsingKey:@"zhyq_20001234567" andIV:@"0123456789abcdef".jk_base64DecodedData]);
    UIView *one = ({
        UIView *obj = View.addTo(self.view).bgColor(@"random");
        obj.onClick(^(void) {
            SaveInfoVC *info = [[SaveInfoVC alloc] init];
            [self.navigationController pushViewController:info animated:YES];
        });
        obj;
    });
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.offset(0);
        make.height.mas_equalTo(40);
    }];
    
    UIView *two = ({
        UIView *obj = View.addTo(self.view).bgColor(@"random");
        obj.onClick(^(void) {
            //            [self testNetLogManager];
            //            [self testSwiftView];
            [self openScan];
        });
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(one.mas_bottom);
            make.left.right.offset(0);
            make.height.mas_equalTo(40);
        }];
        obj;
    });
    UIView *three = ({
        UIView *obj = View.addTo(self.view).bgColor(@"random");
        obj.onClick(^(void) {
            RandomColorVC *info = [[RandomColorVC alloc] init];
            [self.navigationController pushViewController:info animated:YES];
        });
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(two.mas_bottom);
            make.left.right.offset(0);
            make.height.mas_equalTo(40);
        }];
        obj;
    });
    cycleScrollView = ({
        SDCycleScrollView *obj = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:Img(@"red")];
        obj.autoScrollTimeInterval=3;
        obj.infiniteLoop = YES;
        obj.autoScroll = YES;
        obj.clickItemOperationBlock = ^(NSInteger currentIndex) {
            if (currentIndex==ViewTypePMD) {
                [self.navigationController pushViewController:({
                    WQPMDViewController *obj=[[WQPMDViewController alloc] init];
                    obj.hidesBottomBarWhenPushed=YES;
                    obj;
                })animated:YES];
            }
            Log(currentIndex);
            
        };
        [obj setBannerImageViewContentMode:(UIViewContentModeScaleAspectFill)];
        obj.imageURLStringsGroup = @[
            @"https://images.unsplash.com/photo-1660316795448-21fdd1c466af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDUzMTAwNw&ixlib=rb-1.2.1&q=80&w=1080",
            @"https://images.unsplash.com/photo-1659862925130-816e4f8535ce?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDUzMTAzMw&ixlib=rb-1.2.1&q=80&w=1080",
        ];
        obj;
    });
    cycleScrollView.addTo(self.view);
    [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(three.mas_bottom).offset(10);
        make.height.mas_equalTo(200);
    }];
    
    
    //    self.view.onClick(^(void){
    ////        [self showAlert];//测试弹框
    //        [self test_group];
    //    });
}

- (void)openScan {/**<  打开扫码页面 */
    [self.navigationController pushViewController:({
        ScanCodeVC *obj = [[ScanCodeVC alloc] init];
        obj.hidesBottomBarWhenPushed = YES;
        obj;
    })
                                         animated:YES];
}

- (void)clearWebcache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];// All kinds of data
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                   modifiedSince:[NSDate dateWithTimeIntervalSince1970:0]
                                               completionHandler:^{
        }];
    }
}

- (void)testSwiftView {
    RandomView *a = ({
        RandomView *obj = [[RandomView alloc] init];
        obj.addTo(self.view);
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(180);
            make.left.right.offset(0);
            make.height.mas_equalTo(40);
        }];
        obj;
    });
}

- (void)testNetLogManager {
    [NetLogManager shareManager].tag = @"和多号";
    [NetLogManager shareManager].path = @"1111111111111111111111.url";
    [NetLogManager shareManager].header = @{
        @"abc": @"bldu"
    };
    [NetLogManager shareManager].parameter = @{
        @"1p": @"bldu"
    };
    [NetLogManager shareManager].returnResult = @{
        @"fjhvjxgo": @"这里是返回结果"
    };
    NSLog(@"%@", [NetLogManager shareManager]);
    NSLog(@"\n%@", [NetLogManager shareManager].mj_keyValues);
    
    [NetLogManager shareManager].tag = @"智荟港";
    [NetLogManager shareManager].path = @"222222222222222.url";
    [NetLogManager shareManager].header = @{
        @"2abc": @"bldu"
    };
    [NetLogManager shareManager].parameter = @{
        @"21p": @"bldu"
    };
    [NetLogManager shareManager].returnResult = @{
        @"2fjhvjxgo": @"这里是返回结果"
    };
}

- (void)test_group {/**<  测试gcdgroup  */
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    for (int i = 0; i < 10; i++) {
        dispatch_group_enter(downloadGroup);//备注:dispatch_group_enter 与 dispatch_group_leave成对出现
        [self testblock:^{
            NSLog(@"%d---%d", i, i);
            dispatch_group_leave(downloadGroup);
        }];
    }
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}

- (void)testblock:(void (^)(void))c {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        c();
    });
}

- (void)showAlert {
    AAQYAlertView *view = [AAQYAlertView getView:^(UIView *_Nonnull obj) {
        obj.addTo(self.view);
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }];
    
    view.titles = @[@"确定", @"取消"];
    view.titleLB.str(@"测试");
    view.messageLB.str(@"测试内容");
    [view show];
    
    
    [@"你好" chineseConvertToPinYinFirstLetterWithCompletionBlock:^(NSString *_Nonnull mark) {
        NSLog(@"%@", mark);
    }];
}

- (void)createAttr {/**<  创建富文本 */
    //    id attr=AttStr(@"点击了",AttStr(@"协议").linkForLabel);
    lab = Label.addTo(self.view).bgColor(@"white").lines(3).onLink(^(NSString *text) {
        Log(text);
    });
    lab.userInteractionEnabled = YES;
    [lab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)]];
    
    NSAttributedString *plainText;
    NSAttributedString *plainText1;
    NSAttributedString *linkText;
    NSAttributedString *linkText1;
    
    plainText = [[NSMutableAttributedString alloc] initWithString:@"Add label links with UITapGestureRecognizer"
                                                       attributes:nil];
    linkText = [[NSMutableAttributedString alloc] initWithString:@"我们的东西"
                                                      attributes:@{
        NSForegroundColorAttributeName: [UIColor blueColor]
    }];
    plainText1 = [[NSMutableAttributedString alloc] initWithString:@"普通的"
                                                        attributes:nil];
    
    linkText1 = [[NSMutableAttributedString alloc] initWithString:@"乱七八糟"
                                                       attributes:@{
        NSForegroundColorAttributeName: [UIColor blueColor]
    }];
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] init];
    [attrText appendAttributedString:plainText];
    [attrText appendAttributedString:linkText];
    [attrText appendAttributedString:plainText1];
    [attrText appendAttributedString:linkText1];
    
    NSString *str = attrText.string;
    
    lab.attributedText = attrText;
    
    // ivar -- keep track of the target range so you can compare in the callback
    targetRange = [str rangeOfString:@"我们的东西"];
    puts = [str rangeOfString:@"乱七八糟"];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(50);
        make.right.offset(-20);
    }];
}

- (void)HScro {
    h = [BaseHScrollview new];
    h.addTo(self.view).bgColor(@"random");
    [h mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 100, 100));
    }];
    
    UIView *obj = View.addTo(h.bgView).bgColor(@"random");
    [obj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 100, 100));
        make.width.mas_equalTo(1500);
    }];
}

- (void)getAttr {
    UILabel *one = Label.addTo(self.view).lines(0).lineGap(5).bgColor(@"random")
        .onClick(^(void) {
            Log(@"你好");
        });
    NSString *str = @"<h1>Demo iOS application built to highlight MVP (Model View Presenter) and Clean Architecture concepts</h1>";
    
    one.str([self showInHTMLString:str]);
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(Insets(100, 0, 0, 0));
    }];
}

- (NSAttributedString *)showInHTMLString:(NSString *)str {/**<  根据HTML字符串显示HTML */
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding]
                                                                   options:@{
        NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType
    }
                                                        documentAttributes:nil
                                                                     error:nil];
    
    return attrStr;
}

@end
