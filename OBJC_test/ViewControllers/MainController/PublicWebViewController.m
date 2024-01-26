//
//  PublicWebViewController.m
//  OBJC_test
//
//  Created by maggie.qiu on 2023/8/2.
//

#import "PublicWebViewController.h"

@interface PublicWebViewController ()<WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;
@end

@implementation PublicWebViewController

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }

    return _webView;
}

- (WKWebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        [WKWebViewJavascriptBridge enableLogging];// 开启日志 方便调试
        _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
        [_bridge setWebViewDelegate:self];//设置代理
    }

    return _bridge;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];

    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self seting_new_userContentController];//配合WKScriptMessageHandler使用

    [self load_url];
    [self create_bridge];
}

/// 设置新的 userContentController
- (void)seting_new_userContentController {/**<  <#注释#> */
    self.webView.configuration.userContentController = [self newUserContentController];
}

/// wkwebview 添加 自定义 JavaScript 脚本
- (WKUserContentController *)newUserContentController {
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    NSString *namespace = @"WVJB";
    NSString *js_brige_func_name = @"call_ios_function";
    NSString *headerString = [NSString stringWithFormat:@"function %@(namespace, functionName, args) {\
        if (!window.webkit.messageHandlers[namespace]) return;\
        var wrap = {\"method\": functionName,\"params\": args};\
        window.webkit.messageHandlers[namespace].postMessage(JSON.stringify(wrap));\
    }\
    var wapper = {};", js_brige_func_name];

    NSString *tailString = [NSString stringWithFormat:@"window[\"%@\"] = wapper;", namespace];
    NSMutableArray <NSString *> *functionNames = [[NSMutableArray alloc] initWithArray:@[
                                                      @"videoPlay",
                                                      @"getUserInfo",
                                                      @"gotoApp",
                                                      @"hcy_closeWebViewPopupWindow",
    ]];

    NSMutableArray *javaScriptArrays = [[NSMutableArray alloc] initWithArray:@[headerString]];

    [functionNames enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [javaScriptArrays addObject:[NSString stringWithFormat:@"wapper.%@ = function (message) {%@(\"%@\", \"%@\", message);};",
                                     obj, js_brige_func_name, namespace, obj]];
    }];
    [javaScriptArrays addObject:tailString];


    NSString *jsString = [javaScriptArrays componentsJoinedByString:@""]; // 使用空格连接数组中的元素
    NSLog(@"< dante > result code: %@\n\n", jsString);

    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:jsString
                                                      injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                   forMainFrameOnly:YES];
    [userContentController addUserScript:userScript];

    return userContentController;
}

/// 创建 js 桥
- (void)create_bridge {
    Log(@"进入创建桥......");
    [self.bridge registerHandler:@"hcy_closeWebViewPopupWindow"
                         handler:^(id data, WVJBResponseCallback responseCallback) {
        Log(@"click hcy_closeWebViewPopupWindow");

        responseCallback(@100);
    }];
}

/// 加载 url
- (void)load_url {
    // 获取 "test.html" 文件的本地 URL 路径
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURL *htmlURL = [NSURL fileURLWithPath:htmlPath];

//    NSString *urlString = @"https://caiyun.feixin.10086.cn:7071/portal/caiyunOfficialAccount/index.html?path=zeroYuanThirtyGB#/zeroYuanThirtyGB";
//    NSURL *url = [NSURL URLWithString:urlString];

    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];

    [self.webView loadRequest:request];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载成功!!!!!!");
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *_Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -
#pragma mark WKScriptMessageHandler
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    Log(message.name);
    Log(message.body);
}

@end
