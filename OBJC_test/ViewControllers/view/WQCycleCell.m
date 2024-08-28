//
//  WQCycleCell.m
//  OBJC_test
//
//  Created by maggie.qiu on 2024/8/28.
//

#import "WQCycleCell.h"

@implementation WQCycleCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.image.addTo(self);
    self.textLabel.addTo(self);
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark -
#pragma mark 懒加载
- (id)textLabel {
    if (!_textLabel) {
        _textLabel = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.bgColor(@"black,0.3").color(@"white").centerAlignment.fnt(13);
            obj;
        });
    }
    
    return _textLabel;
}

- (id)image {
    if (!_image) {
        _image = ({
            UIImageView *obj = [[UIImageView alloc] init];
            obj.aspectFill.bgColor(UIColor.clearColor);
            obj;
        });
    }
    
    return _image;
}
@end
