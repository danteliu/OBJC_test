//
//  WQView.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/18.
//

#import "WQView.h"

@implementation WQView
- (void (^)(NSDictionary *_Nonnull res))addModel {
    return ^(NSDictionary *_Nonnull res) {
        WQModel *m = [WQModel mj_objectWithKeyValues:res];
        self.textLable.str(m.name);
        [self.imageBg sd_setImageWithURL:Url(m.imgBgUrl) placeholderImage:Img(@"white")];
    };
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.onClick(^(void) {
            if (self.clickView) {
                self.clickView();
            }
        });
        self.imageBg.addTo(self);
        self.textLable.addTo(self);
        [self.imageBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [self.textLable mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.centerX.centerY.offset(0);//居中
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    
    return self;
}

#pragma mark -
#pragma mark 懒加载
- (id)textLable {
    if (!_textLable) {
        _textLable = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.fnt([UIFont boldSystemFontOfSize:14]).centerAlignment.color(@"white").bgColor(@"black,0.2");
            obj;
        });
    }
    
    return _textLable;
}

- (id)imageBg {
    if (!_imageBg) {
        _imageBg = ({
            UIImageView *obj = [[UIImageView alloc] init];
            obj.aspectFill.clip.img(@"random");
            obj;
        });
    }
    
    return _imageBg;
}

@end

@implementation WQModel

@end
