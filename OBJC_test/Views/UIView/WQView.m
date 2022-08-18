//
//  WQView.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/18.
//

#import "WQView.h"

@implementation WQView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgColor(@"random").onClick(^(void){
            if (self.clickView) {
                self.clickView();
            }
        });
        self.textLable.addTo(self);
        [self.textLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);//居中
        }];
    }
    return self;
}
#pragma mark -
#pragma mark 懒加载
-(id)textLable{
    if (!_textLable) {
        _textLable=({
            UILabel *obj=[[UILabel alloc] init];
            obj.fnt([UIFont boldSystemFontOfSize:14]).color(@"white");
            obj;
        });
    }
    return _textLable;
}

@end
