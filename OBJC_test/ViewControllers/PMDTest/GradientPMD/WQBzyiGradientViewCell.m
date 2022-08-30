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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:50];
    [self addSubview:self.textLabel];
}

- (void)setTitle:(NSString *)title {
    self.textLabel.text = title;
    self.bgColor([self dd][title]);
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

@end
