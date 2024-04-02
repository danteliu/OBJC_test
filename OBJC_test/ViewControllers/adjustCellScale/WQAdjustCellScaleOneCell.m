//
//  WQAdjustCellScaleOneCell.m
//  OBJC_test
//
//  Created by maggie.qiu on 2024/4/1.
//

#import "WQAdjustCellScaleOneCell.h"

@implementation WQAdjustCellScaleOneCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setupSubviews];
    }

    return self;
}

- (void)setupSubviews {
    // 初始化和配置 UILabel
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.font = [UIFont systemFontOfSize:16.0];
    [self.contentView addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

@end
