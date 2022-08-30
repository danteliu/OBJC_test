//
//  WQBzyiGradientViewCell.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/30.
//

#import "WQBzyiGradientViewCell.h"


@interface WQBzyiGradientViewCell ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation WQBzyiGradientViewCell
- (void (^)(id _Nonnull res))addModel {
    return ^(id _Nonnull res) {
        self.textLabel.str(res).bgColor([self dd][res]);
    };
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.textLabel.addTo(self);
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setTitle:(NSString *)title {
    //    self.bgColor(@"random");
}

- (NSDictionary *)dd {
    return @{
        @"1": @"#002ea6",
        @"2": @"#ffe78f",
        @"3": @"#d7000f",
        @"4": @"#ff770f",
        @"5": @"#91b822",
    };
}

- (id)textLabel {
    if (!_textLabel) {
        _textLabel = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.textAlignment = NSTextAlignmentCenter;
            obj.font = [UIFont fontWithName:@"AmericanTypewriter" size:50];
            obj;
        });
    }
    
    return _textLabel;
}

@end
