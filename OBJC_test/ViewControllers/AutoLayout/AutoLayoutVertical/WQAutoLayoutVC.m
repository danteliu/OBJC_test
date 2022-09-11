//
//  WQAutoLayoutVC.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/5.
//

#import "WQAutoLayoutVC.h"
#import "LayoutViews.h"
@interface WQAutoLayoutVC ()
@property (nonatomic, strong) BaseVScrollview *vScroll;/**<  <#属性注释#> */
@property (nonatomic, strong) UIView *viewItemsBg; /**<  <#属性注释#> */
@property (nonatomic, strong) NSMutableArray <UIView *> *viewDatas;/**<  <#属性注释#> */

@end

@implementation WQAutoLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(@"white");
    self.hbd_barTintColor = Color(@"white,1");
    self.hbd_barShadowHidden = YES;
    self.title = @"自动竖布局视图";
    [self setupUI];
    
}
-(void)setupUI{
    self.vScroll.addTo(self.view);
    self.viewItemsBg.addTo(self.vScroll.bgView);
    [self.vScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.viewItemsBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self viewRalationshipLayout];
}
-(void)viewRalationshipLayout{
    __block UIView *oldView=self.viewDatas.firstObject;
    UIView *supView=self.viewItemsBg;
    [self.viewDatas enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.addTo(supView);
        if (idx==0) {//第一个
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.offset(0);
            }];
        }else if(idx==self.viewDatas.count-1){//最后一个
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(oldView.mas_bottom).offset(0);
                make.left.bottom.right.offset(0);
            }];
        }else{
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(oldView.mas_bottom).offset(0);
                make.left.right.offset(0);
            }];
            oldView=obj;
        }
    }];
    
}
#pragma mark -
#pragma mark 懒加载
-(id)viewDatas{
    if (!_viewDatas) {
        _viewDatas=({
            NSMutableArray *obj=[[NSMutableArray alloc] init];
            [obj addObject:({
                WQLeftAndRightLabelView *m=[[WQLeftAndRightLabelView alloc] init];

                m;
            })];
         
            [obj addObject:({
                WQStyle0001View *m=[[WQStyle0001View alloc] init];
                
                m;
            })];
          
            [obj addObject:({
                WQStyle0001View *m=[[WQStyle0001View alloc] init];
                
                m;
            })];
            obj;
        });
    }
    return _viewDatas;
}
- (id)vScroll {
    if (!_vScroll) {
        _vScroll = ({
            BaseVScrollview *obj = [[BaseVScrollview alloc] init];
            obj.infoSv.alwaysBounceVertical = YES;
            obj;
        });
    }
    
    return _vScroll;
}
-(id)viewItemsBg{
    if (!_viewItemsBg) {
        _viewItemsBg=({
            UIView *obj=[[UIView alloc] init];
            obj.bgColor(@"white");
            obj;
        });
    }
    return _viewItemsBg;
}


@end
