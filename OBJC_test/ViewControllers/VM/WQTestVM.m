//
//  WQTestVM.m
//  OBJC_test
//
//  Created by maggie.qiu on 2024/8/28.
//

#import "OBJC_test-Swift.h"
#import "WQTestVM.h"

@implementation WQTestVM{
    BaseHScrollview *h;
    UILabel *lab;
    NSRange targetRange;
    NSRange puts;
}
#pragma mark -
#pragma mark main 
- (void)run {
    DDLog(@"开始运行测试");
    [self convertUTCDateToLocal];
    
    DDLog(@"运行测试结束");
}

#pragma mark -
#pragma mark test finish: 测试完成的功能
/// 显示html文本
- (void)getAttr {
    UILabel *one = Label.addTo(self.currentViewContoller.view).lines(0).lineGap(5).bgColor(@"random")
        .onClick(^(void) {
            Log(@"你好");
        });
    NSString *str = @"<h1>Demo iOS application built to highlight MVP (Model View Presenter) and Clean Architecture concepts</h1>";
    
    one.str([self showInHTMLString:str]);
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(Insets(100, 0, 0, 0));
    }];
}

/// 根据HTML字符串显示HTML
/// - Parameter str: html字符串
- (NSAttributedString *)showInHTMLString:(NSString *)str {
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding]
                                                                   options:@{
        NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType
    }
                                                        documentAttributes:nil
                                                                     error:nil];
    
    return attrStr;
}

#pragma mark -
#pragma mark test Module
/// 0时区时间转换成对应时区时间 测试
- (void)convertUTCDateToLocal {
    // 假设从服务器获取到的 UTC 时间字符串
    NSString *utcDateString = @"2024-08-28T08:00:00Z"; // 示例 UTC 时间（ISO 8601 格式）
    
    // 创建日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 设置日期格式为 UTC 时间
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"]; // 设置时区为 UTC
    
    // 将字符串转换为 NSDate
    NSDate *utcDate = [dateFormatter dateFromString:utcDateString];
    
    // 获取系统的时区
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    
    // 创建一个新的日期格式化器用于输出本地时间
    NSDateFormatter *localDateFormatter = [[NSDateFormatter alloc] init];
    localDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss"; // 设定输出格式
    localDateFormatter.timeZone = localTimeZone; // 设置为本地时区
    
    // 将 UTC 时间转换为本地时间
    NSString *localDateString = [localDateFormatter stringFromDate:utcDate];
    
    // 输出结果
    NSLog(@"UTC Time: %@", utcDateString);
    NSLog(@"Local Time: %@", localDateString);
}

/// 获取所有时区的时间
/// - Parameter utcDateString: utc时间  ==  零时区时间
- (NSString *)convertUTCDateToLocalTimeForAllTimeZones:(NSString *)utcDateString {
    // 创建日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 设置日期格式为 UTC 时间
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"]; // 设置时区为 UTC
    
    // 将字符串转换为 NSDate
    NSDate *utcDate = [dateFormatter dateFromString:utcDateString];
    
    if (!utcDate) {
        NSLog(@"Invalid UTC date string: %@", utcDateString);
        return nil; // 处理无效的日期字符串
    }
    
    // 获取本地时区
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    NSString *localTimeZoneName = localTimeZone.name;
    
    // 存储所有时区的时间
    NSMutableDictionary *timeZoneDateStrings = [NSMutableDictionary dictionary];
    
    // 获取所有时区
    NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
    
    // 遍历所有时区并转换为对应的时间
    for (NSString *timeZoneName in timeZoneNames) {
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:timeZoneName];
        
        // 创建一个新的日期格式化器用于输出当地时间
        NSDateFormatter *localDateFormatter = [[NSDateFormatter alloc] init];
        localDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss"; // 设定输出格式
        localDateFormatter.timeZone = timeZone; // 设置为当前时区
        
        // 将 UTC 时间转换为对应时区的时间
        NSString *localDateString = [localDateFormatter stringFromDate:utcDate];
        
        // 存储该时区的时间
        timeZoneDateStrings[timeZoneName] = localDateString;
    }
    
    // 输出所有时区的时间
    for (NSString *key in timeZoneDateStrings) {
        NSLog(@"Time in %@: %@", key, timeZoneDateStrings[key]);
    }
    
    // 返回与本地时区名称对应的时间
    NSString *localTimeString = timeZoneDateStrings[localTimeZoneName];
    
    if (localTimeString) {
        NSLog(@"Local Time in %@: %@", localTimeZoneName, localTimeString);
        return localTimeString;
    } else {
        NSLog(@"Local time not found for time zone: %@", localTimeZoneName);
        return nil;
    }
}

/// 测试返回值为空的情况
- (void)picScale {
    UIImageView *imageV = ({
        UIImageView *obj = [[UIImageView alloc] init];
        obj.contentMode = UIViewContentModeScaleAspectFill;
        obj.clipsToBounds = YES;
        obj;
    });
    
    [self.currentViewContoller.view addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(17);
        make.left.equalTo(self.currentViewContoller.view.mas_left).offset(15);
        make.height.mas_equalTo(14);
    }];
    NSString *urlString = @"https://pay.shop.10086.cn/file/tpctrqqtubpbx67qxb";//1x
    
    //    urlString = @"https://th.bing.com/th/id/R.748160bf925a7acb3ba1c9514bbc60db?rik=AYY%2bJ9WcXYIMgw&riu=http%3a%2f%2fseopic.699pic.com%2fphoto%2f50017%2f0822.jpg_wh1200.jpg&ehk=CMVcdZMU6xxsjVjafO70cFcmJvD62suFC1ytk8UuAUk%3d&risl=&pid=ImgRaw&r=0";
    
    //    urlString = @"https://pay.shop.10086.cn/file/tpctrqs9r86bxhd6bd";//3x
    
    [imageV sd_setImageWithURL:Url(urlString)
                     completed:^(UIImage *_Nullable image, NSError *_Nullable error, SDImageCacheType cacheType, NSURL *_Nullable imageURL) {
        Log(image); //image: <UIImage: 0x280d2dc70>, {79, 28}
    }];
}

/// 清除浏览器缓存
- (void)clearWebcache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];// All kinds of data
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                   modifiedSince:[NSDate dateWithTimeIntervalSince1970:0]
                                               completionHandler:^{
        }];
    }
}

/// 测试 oc 桥接 SwiftView
- (void)testSwiftView {
    RandomView *a = ({
        RandomView *obj = [[RandomView alloc] init];
        obj.addTo(self.currentViewContoller.view);
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(180);
            make.left.right.offset(0);
            make.height.mas_equalTo(40);
        }];
        obj;
    });
}

/// 测试网络信息管理类
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

/// 测试 gcd group
- (void)test_group {
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

/// 测试block回调
/// - Parameter c: <#c description#>
- (void)testblock:(void (^)(void))c {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        c();
    });
}

/// 测试自定义弹窗
- (void)showAlert {
    AAQYAlertView *view = [AAQYAlertView getView:^(UIView *_Nonnull obj) {
        obj.addTo(self.currentViewContoller.view);
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

/// 创建富文本
- (void)createAttr {
    //    id attr=AttStr(@"点击了",AttStr(@"协议").linkForLabel);
    lab = Label.addTo(self.currentViewContoller.view).bgColor(@"white").lines(3).onLink(^(NSString *text) {
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

/// 横向滚动 scorllview
- (void)HScro {
    h = [BaseHScrollview new];
    h.addTo(self.currentViewContoller.view).bgColor(@"random");
    [h mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 100, 100));
    }];
    
    UIView *obj = View.addTo(h.bgView).bgColor(@"random");
    [obj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 100, 100));
        make.width.mas_equalTo(1500);
    }];
}

@end
