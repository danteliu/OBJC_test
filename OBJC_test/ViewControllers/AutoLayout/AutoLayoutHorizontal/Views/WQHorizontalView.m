//
//  WQHorizontalView.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/6.
//

#import "WQHorizontalView.h"

@interface WQHorizontalView ()
@property (nonatomic, strong) UILabel * label;/**<  <#属性注释#> */
@end

@implementation WQHorizontalView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.label.addTo(self);
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo(50);
    }];
    
}

#pragma mark -
#pragma mark 懒加载
-(id)label{
    if (!_label) {
        _label=({
            UILabel *obj=[[UILabel alloc] init];
            obj.bgColor(@"random").centerAlignment.str(@"1");
            obj;
        });
    }
    return _label;
}
@end
