//
//  HDHScrollPlusView.m
//  OneCardMultiNumber
//
//  Created by liu dante on 2021/8/6.
//  Copyright © 2021 和多号. All rights reserved.
//

#import "HDHScrollPlusView.h"
#import <Masonry/Masonry.h>

@implementation HDHScrollPlusView{
    UIView *bgView;
    UIScrollView *contentScrol;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}
-(UIView *)layoutView{
    return bgView;
}
-(UIScrollView *)Scrol{
    return contentScrol;
}
-(void)initSubView{
    contentScrol=[UIScrollView new];
    contentScrol.addTo(self);
    [contentScrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    bgView=View.addTo(contentScrol);
}
-(void)layoutSubviews{
    [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.Dire==ScrollDireH) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.right.offset(0);
        }else if(self.Dire==ScrollDireV){
            make.left.right.equalTo(self).offset(0);
            make.top.bottom.offset(0);
        }
    }];
}

@end
