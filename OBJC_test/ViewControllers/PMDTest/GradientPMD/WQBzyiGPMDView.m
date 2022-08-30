//
//  WQBzyiGPMDView.m
//  OBJC_test
//
//  Created by liu dante on 2022/8/28.
//

#import "WQBzyiGPMDView.h"

@implementation WQBzyiGPMDView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self.layer addSublayer:self.gradientLayer];
        
        self.cc.addTo(self);
        
        [self.cc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(60);
            //            make.left.right.offset(0); //紧贴上部
            make.left.offset(25);
            make.right.offset(-25);
            make.bottom.offset(0);
            make.height.mas_equalTo(200);
        }];
        [self.cc loadData:[NSMutableArray arrayWithArray:self.datas]];
        [self changeGradientLayerColor:Color([self dd][@"0"])];//设置第一个颜色
        __weak __typeof__(self) weakSelf = self;
        //        __typeof__(self) strongSelf = weakSelf;
        self.cc.scaleBlock = ^(PageManager *_Nonnull pageM) {
         
            UIColor *colorCur = Color([weakSelf dd][pageM.colorCurrent]);
            UIColor *colorLast = Color([weakSelf dd][pageM.colorLast]);
            UIColor *colorBefore = Color([weakSelf dd][pageM.colorBefore]);
            
            NSMutableArray *arrColorCur = [weakSelf changeUIColorToRGB:colorCur];
            NSMutableArray *arrColorLast = [weakSelf changeUIColorToRGB:colorLast];
            NSMutableArray *arrColorBefore = [weakSelf changeUIColorToRGB:colorBefore];
            
            if (pageM.direction == ScrollDirectionRight) {
                UIColor *changeColor = [weakSelf getChangeColor:arrColorCur targetColors:arrColorLast scale:pageM.scale];
                [weakSelf changeGradientLayerColor:changeColor];
            } else if (pageM.direction == ScrollDirectionLeft) {
                UIColor *changeColor = [weakSelf getChangeColor:arrColorBefore targetColors:arrColorCur scale:pageM.scale];
                [weakSelf changeGradientLayerColor:changeColor];
            }
        };
    }
    
    return self;
}

- (UIColor *)getChangeColor:(NSMutableArray *)colorCurs targetColors:(NSMutableArray *)targetColors scale:(CGFloat)scale {/**<  根据比例获取颜色 */
    CGFloat currentR = [(NSNumber *)colorCurs[0] floatValue];
    CGFloat currentG = [(NSNumber *)colorCurs[1] floatValue];
    CGFloat currentB = [(NSNumber *)colorCurs[2] floatValue];
    
    
    CGFloat targetR = [(NSNumber *)targetColors[0] floatValue];
    CGFloat targetG = [(NSNumber *)targetColors[1] floatValue];
    CGFloat targetB = [(NSNumber *)targetColors[2] floatValue];
    
    CGFloat rColorFloat =  currentR + ((targetR - currentR) * scale);
    CGFloat gColorFloat =  currentG + ((targetG - currentG) * scale);
    CGFloat bColorFloat =  currentB + ((targetB - currentB) * scale);
    
    return [UIColor colorWithRed:rColorFloat / 255.0 green:gColorFloat / 255.0 blue:bColorFloat / 255.0 alpha:1.0];
}

- (void)changeGradientLayerColor:(UIColor *)hexColor {/**<  改变渐变图层颜色 */
//    //删除隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];

    self.gradientLayer.colors = @[
        (__bridge id)hexColor.CGColor,
        (__bridge id)UIColor.whiteColor.CGColor,
    ];
    
    [CATransaction commit];
 
}

- (NSDictionary *)dd {
    return @{
        @"0": @"#002ea6",
        @"1": @"#ffe78f",
        @"2": @"#d7000f",
        @"3": @"#ff770f",
        @"4": @"#91b822",
    };
}

- (NSMutableArray *)changeUIColorToRGB:(UIColor *)color {
    NSMutableArray *RGBStrValueArr = [[NSMutableArray alloc] init];
    NSString *RGBStr = @"";
    
    //获得色值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@", color];
    //将色值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    
    if (RGBArr > 0) {
        NSString *colorStatus = RGBArr.firstObject;
        
        if ([colorStatus isEqualToString:@"UIExtendedSRGBColorSpace"] && RGBArr.count >= 5) {
            //获取红色值
            double r = [[RGBArr objectAtIndex:1] doubleValue] * 255;
            RGBStr = [NSString stringWithFormat:@"%ff", r];
            [RGBStrValueArr addObject:RGBStr];
            //获取绿色值
            double g = [[RGBArr objectAtIndex:2] doubleValue] * 255;
            RGBStr = [NSString stringWithFormat:@"%ff", g];
            [RGBStrValueArr addObject:RGBStr];
            //获取蓝色值
            double b = [[RGBArr objectAtIndex:3] doubleValue] * 255;
            RGBStr = [NSString stringWithFormat:@"%ff", b];
            [RGBStrValueArr addObject:RGBStr];
            
            //获取透明度
            double a = [[RGBArr objectAtIndex:4] doubleValue] * 255;
            RGBStr = [NSString stringWithFormat:@"%ff", a];
            [RGBStrValueArr addObject:RGBStr];
            //返回保存RGB值的数组
        } else if ([colorStatus isEqualToString:@"UIExtendedGrayColorSpace"] && RGBArr.count >= 3) {
            //获取红色值
            double r = [[RGBArr objectAtIndex:1] doubleValue] * 255;
            RGBStr = [NSString stringWithFormat:@"%ff", r];
            [RGBStrValueArr addObject:RGBStr];
            //获取绿色值
            double g = [[RGBArr objectAtIndex:1] doubleValue] * 255;
            RGBStr = [NSString stringWithFormat:@"%ff", g];
            [RGBStrValueArr addObject:RGBStr];
            //获取蓝色值
            double b = [[RGBArr objectAtIndex:1] doubleValue] * 255;
            RGBStr = [NSString stringWithFormat:@"%ff", b];
            [RGBStrValueArr addObject:RGBStr];
            
            //获取透明度
            double a = [[RGBArr objectAtIndex:2] doubleValue] * 255;
            RGBStr = [NSString stringWithFormat:@"%ff", a];
            [RGBStrValueArr addObject:RGBStr];
        }
    }
    
    return RGBStrValueArr;
}

- (void)layoutSubviews {
    self.gradientLayer.frame = self.bounds;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = ({
            CAGradientLayer *obj = [[CAGradientLayer alloc] init];
            obj.colors = @[
                (__bridge id)UIColor.whiteColor.CGColor,
                (__bridge id)UIColor.whiteColor.CGColor,
            ];
            obj.locations = @[@0.0, @1];// 颜色分割点
            obj.startPoint = CGPointMake(0, 0);// 开始点
            obj.endPoint = CGPointMake(0, 1);  // 结束点
            obj;
        });
    }
    
    return _gradientLayer;
}
#pragma mark -
#pragma mark 懒加载
- (id)cc {
    if (!_cc) {
        _cc = ({
            WQBzyiGradientView *obj = [[WQBzyiGradientView alloc] init];
            
            obj;
        });
    }
    
    return _cc;
}
-(id)datas{
    if (!_datas) {
        _datas=({
            NSMutableArray *obj=[[NSMutableArray alloc] init];
            [obj addObject:@"1"];
            [obj addObject:@"2"];
            [obj addObject:@"3"];
            [obj addObject:@"4"];
            [obj addObject:@"5"];
            obj;
        });
    }
    return _datas;
}
@end
