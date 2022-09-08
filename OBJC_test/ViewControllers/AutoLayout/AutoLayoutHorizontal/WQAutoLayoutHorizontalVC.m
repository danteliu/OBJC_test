//
//  WQAutoLayoutHorizontalVC.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/6.
//

#import "WQAutoLayoutHorizontalVC.h"

@interface WQAutoLayoutHorizontalVC ()
@property (nonatomic, strong) BaseHScrollview *hScroll;/**<  <#属性注释#> */
@property (nonatomic, strong) UIView *viewItemsBg; /**<  <#属性注释#> */
@property (nonatomic, strong) NSMutableArray <UIView *> *viewDatas;/**<  <#属性注释#> */

@end

@implementation WQAutoLayoutHorizontalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(@"white");
    self.hbd_barTintColor = Color(@"white,1");
    self.hbd_barShadowHidden = YES;
    self.title = @"自动横布局视图";
    [self setupUI];
}

- (void)setupUI {
    self.hScroll.addTo(self.view);
    self.viewItemsBg.addTo(self.hScroll.bgView);
    [self.hScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.viewItemsBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    CGFloat price=9.9+19.9+7.8+45.9+14.9+19.9+39.8+7.8+79;
    NSString *priceStr=Str(@"%.2f",price);
    Log(priceStr);
    [self viewRalationshipLayout];
}

- (void)viewRalationshipLayout {
    __block UIView *oldView = self.viewDatas.firstObject;
    UIView *supView = self.viewItemsBg;

    [self.viewDatas enumerateObjectsUsingBlock:^(UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        obj.addTo(supView);

        if (idx == 0) {//第一个
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.offset(0);
            }];
        } else if (idx == self.viewDatas.count - 1) {//最后一个
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(oldView.mas_right).offset(0);
                make.right.offset(0);
                make.top.bottom.offset(0);
            }];
        } else {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(oldView.mas_right).offset(0);
                make.top.bottom.offset(0);
            }];
            oldView = obj;
        }
    }];
}

#pragma mark -
#pragma mark 懒加载
- (id)viewDatas {
    if (!_viewDatas) {
        _viewDatas = ({
            NSMutableArray *obj = [[NSMutableArray alloc] init];
            [obj addObject:({
                WQHorizontalView *m = [[WQHorizontalView alloc] init];
                m;
            })];
            [obj addObject:({
                WQHorizontalView *m = [[WQHorizontalView alloc] init];
                
                m;
            })];
            [obj addObject:({
                WQHorizontalView *m = [[WQHorizontalView alloc] init];
                
                m;
            })];
            [obj addObject:({
                WQHorizontalView *m = [[WQHorizontalView alloc] init];
                
                m;
            })];
            [obj addObject:({
                WQHorizontalView *m = [[WQHorizontalView alloc] init];
                
                m;
            })];
            
            
            
            
            obj;
        });
    }
    
    return _viewDatas;
}

- (id)hScroll {
    if (!_hScroll) {
        _hScroll = ({
            BaseHScrollview *obj = [[BaseHScrollview alloc] init];
            obj.infoSv.alwaysBounceHorizontal = YES;
            obj;
        });
    }
    
    return _hScroll;
}

- (id)viewItemsBg {
    if (!_viewItemsBg) {
        _viewItemsBg = ({
            UIView *obj = [[UIView alloc] init];
            obj.bgColor(@"white");
            obj;
        });
    }
    
    return _viewItemsBg;
}

@end
