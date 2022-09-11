//
//  WQStyle0001View.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/5.
//

#import "WQStyle0001View.h"
@interface WQStyle0001View ()

@end

@implementation WQStyle0001View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.labelLeft.addTo(self);
    [self.labelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
        make.height.mas_equalTo(120);
    }];
}
- (NSMutableAttributedString *)getPriceAttribute:(NSString *)string {/**<  1185价格的富文本 */
    NSMutableAttributedString *tempAttr = [[NSMutableAttributedString alloc] initWithString:string];

    [tempAttr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:40] range:NSMakeRange(1, string.length - 2)];
    return tempAttr;
}
#pragma mark -
#pragma mark 懒加载
- (id)labelLeft {
    if (!_labelLeft) {
        _labelLeft = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.bgColor(@"random").color(@"red").centerAlignment.fnt(22).str([self getPriceAttribute:@"¥4443起"]);
            
            obj;
        });
    }
    return _labelLeft;
}

@end
