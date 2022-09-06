//
//  WQLeftAndRightLabelView.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/5.
//

#import "WQLeftAndRightLabelView.h"

@interface WQLeftAndRightLabelView ()

@end

@implementation WQLeftAndRightLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.labelLeft.addTo(self);
    [self.labelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
        make.height.mas_equalTo(44);
    }];
}
#pragma mark -
#pragma mark 懒加载
-(id)labelLeft{
    if (!_labelLeft) {
        _labelLeft=({
            UILabel *obj=[[UILabel alloc] init];
            obj.bgColor(@"random").str(@"1");
            obj;
        });
    }
    return _labelLeft;
}
@end
