//
//  ViewController.m
//  OBJC_test
//
//  Created by liu dante on 2021/7/27.
//


#import "ViewController.h"
@interface ViewController ()
/// 设置UI界面 VM
@property (nonatomic, strong) WQSetUIVM *setUIVM;
@property (nonatomic, strong) WQTestVM *testVM;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.setUIVM setupUI];
    [self.testVM run];
}

#pragma mark -
#pragma mark 懒加载
- (WQSetUIVM *)setUIVM {
    if (!_setUIVM) {
        _setUIVM = [[WQSetUIVM alloc] init];
        _setUIVM.currentViewContoller = self;
    }
    
    return _setUIVM; // 返回实例
}

- (WQTestVM *)testVM {
    if (!_testVM) {
        _testVM = [[WQTestVM alloc] init];
        _testVM.currentViewContoller = self;
    }
    
    return _testVM; // 返回实例
}

@end
