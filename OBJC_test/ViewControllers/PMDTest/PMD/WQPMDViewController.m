//
//  DantePMDViewController.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/15.
//

#import "WQPMDViewController.h"

@interface WQPMDViewController ()

@end

@implementation WQPMDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(@"white");
    self.hbd_barTintColor = Color(@"white,1");
    self.title=@"跑马灯";
    self.hScrollView.addTo(self.view);
    [self.hScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.right.offset(0);//紧贴上部
        make.height.mas_equalTo(200);
    }];
    
    [self.itemViews mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.itemViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.mas_equalTo(120);
    }];
    
    [self startAnimation];
}
-(void)startAnimation{
    
    [self.hScrollView layoutIfNeeded];
    CGFloat targetX = self.hScrollView.bgView.w / 2.0;
    CGFloat screenW=Screen.width;
    [self.hScrollView.bgView.layer removeAllAnimations];
    self.scrollAnimation.duration = 10 * ceil(targetX/screenW);
    self.scrollAnimation.fromValue = [NSNumber numberWithDouble:targetX+screenW];
    self.scrollAnimation.toValue = [NSNumber numberWithDouble:-targetX];
    [self.hScrollView.bgView.layer addAnimation:self.scrollAnimation forKey:@"inda"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"anim--class-->>%@--%@",[anim description],anim);
    
    if ([self.hScrollView.bgView.layer animationForKey:@"inda"] == anim) {
        NSLog(@"selectImgAniGroup----Stop");
    }
    Log(anim);
    Log(flag);
    
}
#pragma mark -
#pragma mark 懒加载
-(id)itemViews{
    if (!_itemViews) {
        _itemViews=({
            NSMutableArray *obj=[[NSMutableArray alloc] init];
            for (NSInteger i=0; i<2; i++) {
                UIView *view=View.addTo(self.hScrollView.bgView).bgColor(@"random");
                [obj addObject:view];
            }
            obj;
        });
    }
    return _itemViews;
}
-(id)hScrollView{
    if (!_hScrollView) {
        _hScrollView=({
            BaseHScrollview *obj=[[BaseHScrollview alloc] init];
            obj.infoSv.alwaysBounceHorizontal=YES;
            obj;
        });
    }
    return _hScrollView;
}
-(id)scrollAnimation{
    if (!_scrollAnimation) {
        _scrollAnimation=({
            CABasicAnimation *obj=[CABasicAnimation animationWithKeyPath:@"position.x"];
            obj.delegate=self;
            obj.repeatCount=CGFLOAT_MAX;
            obj.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            //动画维持结束后的状态,如果不加这两句代码，动画运行结束后会恢复最初的动画状态
            obj.removedOnCompletion = NO;
            obj.fillMode = kCAFillModeForwards;
            obj;
        });
    }
    return _scrollAnimation;
}
@end
