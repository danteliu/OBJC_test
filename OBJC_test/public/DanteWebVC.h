//
//  DanteWebVC.h
//  OBJC_test
//
//  Created by liu dante on 2022/3/18.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DanteWebVC : UIViewController<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *web;/**<  底层视图 */
@end
NS_ASSUME_NONNULL_END
