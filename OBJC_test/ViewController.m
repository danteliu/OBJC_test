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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *one=View.addTo(self.view).bgColor(@"random")
    .onClick(^(UIView *s){
        Log(@"你好");
    });
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
}


@end
