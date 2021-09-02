//
//  AAQYAlertView.m
//  OBJC_test
//
//  Created by liu dante on 2021/9/2.
//

#import "AAQYAlertView.h"

@implementation AAQYAlertView{
    UIView *contentView;
    UIView *btnsBg;
    UILabel *titleLabel;/**<  标题 */
    UILabel* messageLabel;/**<  信息 */
}
-(UILabel *)titleLB{
    return titleLabel;
}
-(UILabel* )messageLB{
    return messageLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles=@[];
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    self.backgroundColor=Color(@"#000000,0.7");
//    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
    contentView=[UIView getView:^(UIView *obj) {
        obj.layer.cornerRadius=12;
        obj.backgroundColor=UIColor.whiteColor;
        [self addSubview:obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);//居中
            make.left.offset(20);
            make.right.offset(-20);
        }];
    }];
    
    UIView *titleBg=[UIView getView:^(UIView *obj) {
        obj.backgroundColor=UIColor.blackColor;
        obj.layer.cornerRadius=12;
        obj.layer.masksToBounds=YES;
        [contentView addSubview:obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(contentView.mas_top).offset(0);
            make.centerX.offset(0);
        }];
    }];
    
    titleLabel = [UILabel getView:^(UIView *obj) {
        [titleBg addSubview:obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(7, 20, 7, 20));
        }];
    }];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = @"默认标题";
    titleLabel.numberOfLines = 1;
    
    messageLabel = [UILabel getView:^(UIView *obj) {
        [contentView addSubview:obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.right.offset(-20);
            make.top.equalTo(titleBg.mas_bottom).offset(16);
        }];
    }];
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = Color(@"#585858");
    messageLabel.font = [UIFont systemFontOfSize:16];
    messageLabel.numberOfLines=0;
    messageLabel.text=@"默认信息";
    btnsBg=[UIView getView:^(UIView *obj) {
        [contentView addSubview:obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.right.offset(-20);
            make.top.equalTo(messageLabel.mas_bottom).offset(16);
            make.bottom.offset(-20);
        }];
    }];
}
-(void)clickbtn:(UIButton *)btn{/**<  点击btn */
    [self close];
    NSInteger tag=btn.tag;
    if (tag==20) {
        tag=-1;
    }else{
        tag=tag-30;
    }
    if (self.onclickBtn) {
        self.onclickBtn(self, tag);
    }
}
-(NSDictionary*)getBtnBgCorDic{/**<  按钮的背景设置丨重要  */
    return @{
        @"允许":@"#4DC591",
        @"同意":@"#4DC591",
        @"下次一定":@"#D8D8DC",
        @"确定":@"#4DC591",
        @"确 定":@"4DC591",
        @"默认":@"#D8D8DC",
    };
}
-(void)layoutSubviews{
    if (_titles.count<=1) {
        UIButton *btn=[UIButton getView:^(UIView *newObj) {
            newObj.layer.cornerRadius=10;
            newObj.tag=20;
            [btnsBg addSubview:newObj];
            [newObj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsZero);
                make.height.mas_equalTo(50);
            }];
        }];
        [btn setTitle:_titles.count==0?@"确 定":_titles.firstObject forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(clickbtn:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.backgroundColor=Color([self getBtnBgCorDic][@"确定"]);
        return;
    }
    NSMutableArray *views=[NSMutableArray new];
    [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn=[UIButton getView:^(UIView *newObj) {
            newObj.layer.cornerRadius=10;
            newObj.tag=30+idx;
            [views addObject:newObj];
            [btnsBg addSubview:newObj];
        }];
        [btn setTitle:(NSString *)obj forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(clickbtn:) forControlEvents:(UIControlEventTouchUpInside)];
        NSString*btnBgStr= [self getBtnBgCorDic][obj]==nil?[self getBtnBgCorDic][@"默认"]:[self getBtnBgCorDic][obj];
        btn.backgroundColor=Color(btnBgStr);
        if (idx==0) {
            btn.backgroundColor=Color([self getBtnBgCorDic][@"确定"]);
        }
    }];
    
    [views mas_distributeViewsAlongAxis:(MASAxisTypeVertical) withFixedSpacing:16 leadSpacing:0 tailSpacing:0];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(50);
    }];
}
- (void)show{
    contentView.layer.shouldRasterize = YES;
    contentView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
  
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    contentView.layer.opacity = 0.5f;
    contentView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);

    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        contentView.layer.opacity = 1.0f;
        contentView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }completion:NULL];
}
- (void)close{
    CATransform3D currentTransform = contentView.layer.transform;
    
    CGFloat startRotation = [[contentView valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
    CATransform3D rotation = CATransform3DMakeRotation(-startRotation + M_PI * 270.0 / 180.0, 0.0f, 0.0f, 0.0f);
    
    contentView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1));
    contentView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
        contentView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
        contentView.layer.opacity = 0.0f;
    }completion:^(BOOL finished) {
        for (UIView *v in [self subviews]) {
            [v removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}

@end


