//
//  DanteWebVC.m
//  OBJC_test
//
//  Created by liu dante on 2022/3/18.
//

#import "DanteWebVC.h"

@interface DanteWebVC ()

@end

@implementation DanteWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)setupUI{
    self.web.addTo(self.view);
    [self.web loadRequest:[[NSURLRequest alloc]initWithURL:Url(@"http://10.1.12.144:28183/mapdemo/#/index")]];

    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:[self scriptNames][0]]) {/** 微信好友分享 */
        NSLog(@"微信好友.body:%@",message.body);
    }
}
-(NSArray <NSString *>*)scriptNames{/**<  添加JavaScript方法名 */
    return @[
        @"WechatFriendsShare",
    ];
}

-(WKWebView *)web{
    if (!_web) {
        _web=({
            /** 创建WKWebView */
            WKWebView* obj = [[WKWebView alloc] init];
            obj.allowsBackForwardNavigationGestures=YES;
//            obj.scrollView.showsHorizontalScrollIndicator=NO;
//            obj.scrollView.showsVerticalScrollIndicator=NO;
            WKWebViewConfiguration *Information = obj.configuration;/** 通过JS与webview内容交互 */
            [self.scriptNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [Information.userContentController addScriptMessageHandler:self name:obj];
            }];
            obj;
        });
    }
    return _web;
}

@end
