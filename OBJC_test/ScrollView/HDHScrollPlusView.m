//
//  HDHScrollPlusView.m
//  OneCardMultiNumber
//
//  Created by liu dante on 2021/8/6.
//  Copyright © 2021 和多号. All rights reserved.
//

#import "HDHScrollPlusView.h"
#import <Masonry/Masonry.h>

@implementation BaseHScrollview
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
        [self addSubview:self.infoSv];
        [self.infoSv addSubview:self.bgView];
        
        [self.infoSv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.right.equalTo(self.infoSv);
        }];
    }
    return self;
}
-(UIScrollView *)infoSv {
    if (!_infoSv) {
        _infoSv=({
            UIScrollView *obj=[[UIScrollView alloc] init];
            obj.backgroundColor=UIColor.clearColor;
            obj;
        });
    }
    return _infoSv;
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView=({
            UIView *obj=[[UIView alloc] init];
            obj;
        });
    }
    return _bgView;
}
@end


@implementation BaseVScrollview
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
        [self addSubview:self.infoSv];
        [self.infoSv addSubview:self.bgView];
        
        [self.infoSv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.infoSv).offset(0);
            make.left.right.equalTo(self);
        }];
    }
    return self;
}
-(UIScrollView *)infoSv {
    if (!_infoSv) {
        _infoSv=({
            UIScrollView *obj=[[UIScrollView alloc] init];
            obj.backgroundColor=UIColor.clearColor;
            obj;
        });
    }
    return _infoSv;
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView=({
            UIView *obj=[[UIView alloc] init];
            obj;
        });
    }
    return _bgView;
}
@end
