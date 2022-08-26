//
//  WQCradientPmdViewController.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/26.
//

#import "WQCradientPmdViewController.h"
#import "WQCradientPmdView.h"
#import "WQBzyiGradientView.h"
@interface WQCradientPmdViewController ()

@end

@implementation WQCradientPmdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(@"white");
    self.hbd_barTintColor = Color(@"white,1");
    self.title = @"渐变跑马灯";
    
//    WQCradientPmdView *dd = ({
//        WQCradientPmdView *obj = [[WQCradientPmdView alloc] init];
//        obj.data = @[
//            @"1",
//            @"2",
//            @"3",
//        ];
//        obj.addTo(self.view);
//        obj;
//    });
//    [dd mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(20);
//        make.left.right.offset(0); //紧贴上部
//        make.height.mas_equalTo(200);
//    }];
    
    WQBzyiGradientView *cc = ({
        WQBzyiGradientView *obj = [[WQBzyiGradientView alloc] init];
        obj.addTo(self.view);
        obj;
    });
    
    [cc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.right.offset(0); //紧贴上部
        make.height.mas_equalTo(200);
    }];
    [cc loadData:[NSMutableArray arrayWithArray:@[
        @"1",
        @"2",
        @"3",
        @"4",
        @"5",
    ]]];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
