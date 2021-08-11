//
//  ViewController.m
//  OBJC_test
//
//  Created by liu dante on 2021/7/27.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    HDHScrollPlusView *h;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self getAttr];
    [self HScro];
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
