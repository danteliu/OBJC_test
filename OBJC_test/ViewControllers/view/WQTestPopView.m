//
//  WQPopView.m
//  OBJC_test
//
//  Created by maggie.qiu on 2024/11/5.
//

#import "WQTestPopView.h"

@implementation WQTestPopView
#pragma mark -
#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)dealloc {
}

#pragma mark -
#pragma mark private method
/// UI 初始化
- (void)setupUI {
    self.backgroundColor = [UIColor colorWithRed:(arc4random() % 256) / 255.0
                                           green:(arc4random() % 256) / 255.0
                                            blue:(arc4random() % 256) / 255.0
                                           alpha:0.7];
    // 添加背景视图
    [self addSubview:self.bgView];

    // 添加色块视图
    [self.bgView addSubview:self.colorBlock1];
    [self.bgView addSubview:self.colorBlock2];
    [self.bgView addSubview:self.colorBlock3];

    // 使用 Masonry 进行布局
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
        make.left.right.insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];

    [self.colorBlock1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset(10);
        make.height.mas_equalTo(100);
        make.left.offset(10);
        make.right.offset(-10);
    }];

    [self.colorBlock2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.colorBlock1.mas_bottom).offset(10);
        make.height.mas_equalTo(60);
        make.left.offset(10);
        make.right.offset(-10);
    }];

    [self.colorBlock3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.colorBlock2.mas_bottom).offset(10);
        make.height.mas_equalTo(80);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
}

#pragma mark -
#pragma mark public method


#pragma mark -
#pragma mark event response


#pragma mark -
#pragma mark setter && getter && lazy
/// 懒加载背景视图
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor; // 随机颜色
    }

    return _bgView;
}

/// 懒加载色块视图
- (UIView *)colorBlock1 {
    if (!_colorBlock1) {
        _colorBlock1 = [[UIView alloc] init];
        _colorBlock1.backgroundColor = [UIColor redColor]; // 设置色块1为红色
    }

    return _colorBlock1;
}

- (UIView *)colorBlock2 {
    if (!_colorBlock2) {
        _colorBlock2 = [[UIView alloc] init];
        _colorBlock2.backgroundColor = [UIColor greenColor]; // 设置色块2为绿色
    }

    return _colorBlock2;
}

- (UIView *)colorBlock3 {
    if (!_colorBlock3) {
        _colorBlock3 = [[UIView alloc] init];
        _colorBlock3.backgroundColor = [UIColor blueColor]; // 设置色块3为蓝色
    }

    return _colorBlock3;
}

@end
