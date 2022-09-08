//
//  WQTimeDependentVC.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/1.
//

#import "WQTimeDependentVC.h"

@interface WQTimeDependentVC ()
@property (nonatomic, strong) BaseVScrollview *vScroll;/**<  <#属性注释#> */
@property (nonatomic, strong) UIView *viewItemsBg; /**<  <#属性注释#> */
@property (nonatomic, strong) UILabel *labelTimeShow; /**<  时间显示器 */
@property (nonatomic, strong) NSMutableArray <UIView *> *viewItems;/**<  <#属性注释#> */

@property (nonatomic, strong) UIDatePicker *datePicker;/**<  时间选择器 */
@property (nonatomic, strong) NSTimer *timer; /**<  <#属性注释#> */

@end

@implementation WQTimeDependentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bgColor(@"white");
    self.hbd_barTintColor = Color(@"white,1");
    self.hbd_barShadowHidden = YES;
    self.title = @"时间相关";
    
    
    self.vScroll.addTo(self.view);
    [self.vScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.datePicker.addTo(self.vScroll.bgView);
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);//紧贴上部
        make.height.mas_equalTo(200);
    }];
    self.viewItemsBg.addTo(self.vScroll.bgView);
    [self.viewItemsBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(200, 0, 0, 0));
    }];
    
    [self.viewItems enumerateObjectsUsingBlock:^(UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        obj.addTo(self.viewItemsBg);
    }];
    [self.viewItems mas_distributeViewsAlongAxis:(MASAxisTypeVertical) withFixedSpacing:0.5 leadSpacing:10 tailSpacing:10];
    [self.viewItems mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)onclick:(WQTimeDependentCell *)sender {/**<  获取时间 */
    NSDate *theDate = self.datePicker.date;
    
    NSLog(@"the date picked is: %@", [theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSLog(@"the date formate is:%@", [dateFormatter stringFromDate:theDate]);
    sender.rightName.str([dateFormatter stringFromDate:theDate]);
}

- (void)checkTime {/**<  时间检查 */
    [self checkTimddddt];
    [self startTime];
}

- (void)dealloc {
    [self stopTime];
}

- (KBJCMCCTimeState)checkTimddddt {
    WQTimeDependentCell *before = [self.viewItemsBg viewWithTag:12];
    WQTimeDependentCell *last = [self.viewItemsBg viewWithTag:14];
    
    NSDate *dateBefore = [RBDateTime dateTimeByParsingString:before.rightName.text withFormat:@"YYYY-MM-dd HH:mm:ss"].NSDate;
    NSDate *dateLast = [RBDateTime dateTimeByParsingString:last.rightName.text withFormat:@"YYYY-MM-dd HH:mm:ss"].NSDate;
    
    NSDate *startDate = dateBefore;
    NSTimeInterval startTimeInterval = [startDate timeIntervalSince1970];
    
    NSDate *endDate = dateLast;
    NSTimeInterval endTimeInterval = [endDate timeIntervalSince1970];
    
    NSTimeInterval nowTimeInterval = [[NSDate date] timeIntervalSince1970];
    
    if (startTimeInterval > 0 && endTimeInterval > 0) {
        /**开始时间和结束时间都有返回值*/
        
        if (endTimeInterval > startTimeInterval) {
            /**正常情况 结束时间要 大于 开始时间*/
            
            if (nowTimeInterval > startTimeInterval) {
                return KBJCMCCTimeState_Begin;/// 活动进行中
            } else if (nowTimeInterval >= endTimeInterval) {
                return KBJCMCCTimeState_End; /// 活动结束
            } else {
                return KBJCMCCTimeState_Prepare; /// 活动未开始
            }
        } else {
            /**非正常情况（例配置错时间）*/
            
            if (startTimeInterval > nowTimeInterval) {
                return KBJCMCCTimeState_Prepare; /// 活动未开始
            } else {
                if (nowTimeInterval < endTimeInterval) {
                    return KBJCMCCTimeState_Begin;
                }
            }
            
            return KBJCMCCTimeState_End;
        }
    } else if (startTimeInterval > 0 && endTimeInterval <= 0) {
        /**开始时间有返回值，结束时间没有返回值*/
        if (nowTimeInterval < startTimeInterval) {
            return KBJCMCCTimeState_Prepare;/**现在时间小于开始时间  即未开始 准备开始*/
        } else {
            return KBJCMCCTimeState_End;
        }
    } else if (startTimeInterval <= 0 && endTimeInterval > 0) {
        /**开始时间有返回值，结束时间没有返回值*/
        if (nowTimeInterval < endTimeInterval) {
            return KBJCMCCTimeState_Begin;/**现在时间小于结束时间  已经开始 未结束*/
        } else {
            return KBJCMCCTimeState_End;
        }
    } else {
        return KBJCMCCTimeState_End;/**开始时间和结束时间没有返回值*/
    }
    
    return KBJCMCCTimeState_End;
}

- (void)startTime {/**<  开启定时器 */
    [self stopTime];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showNext) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTime {/**<  关闭定时器 */
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


- (void)showNext {/**<  开启倒计时 */
    WQTimeDependentCell *before = [self.viewItemsBg viewWithTag:12];
    WQTimeDependentCell *last = [self.viewItemsBg viewWithTag:14];
    
    [self checkTimddddt];
    NSTimeInterval nowTimeInterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval countDownTimeInterval = 0;
    
    if ([self checkTimddddt] == KBJCMCCTimeState_Begin) {
        /**
         已经开始了 计算结束时间与现在时间
         */
        NSDate *endDate = [RBDateTime dateTimeByParsingString:last.rightName.text withFormat:@"YYYY-MM-dd HH:mm:ss"].NSDate;
        NSTimeInterval endTimeInterval = [endDate timeIntervalSince1970];
        countDownTimeInterval = endTimeInterval - nowTimeInterval;
    }
    
    if ([self checkTimddddt] == KBJCMCCTimeState_Prepare) {
        /**
         准备开始（未开始） 计算开始时间与现在时间
         */
        NSDate *startDate = [RBDateTime dateTimeByParsingString:before.rightName.text withFormat:@"YYYY-MM-dd HH:mm:ss"].NSDate;
        NSTimeInterval startTimeInterval = [startDate timeIntervalSince1970];
        NSTimeInterval nowTimeInterval = [[NSDate date] timeIntervalSince1970];
        countDownTimeInterval = startTimeInterval - nowTimeInterval;
    }
    
    NSInteger timeOut = countDownTimeInterval;
    
    if (timeOut <= 0) {
        //        /**倒计时结束*/
        
        if ([self checkTimddddt] == KBJCMCCTimeState_Begin || [self checkTimddddt] == KBJCMCCTimeState_End) {
            self.labelTimeShow.str(@"已结束");
            [self stopTime];
        }
    } else {
        NSInteger days = (NSInteger)(timeOut / (3600 * 24));
        NSInteger hours = (NSInteger)((timeOut - days * 24 * 3600) / 3600);
        NSInteger minute = (NSInteger)(timeOut - days * 24 * 3600 - hours * 3600) / 60;
        NSInteger second = timeOut - days * 24 * 3600 - hours * 3600 - minute * 60;
        //        hours = hours + days*24;
        
        //        self.rightDesLb.text = [self rightDesTextWithTimeState:[self getActivityState]];
        NSString *timeStr = @"";
        
        if (days == 0) {
            timeStr = [NSString stringWithFormat:@"%02ld时%02ld分%02ld秒", hours, minute, second];
        } else {
            timeStr = [NSString stringWithFormat:@"%ld天%02ld时%02ld分%02ld秒", days, hours, minute, second];
        }
        
        self.labelTimeShow.str(timeStr);
    }
}

#pragma mark -
#pragma mark 懒加载
- (id)datePicker {
    if (!_datePicker) {
        _datePicker = ({
            UIDatePicker *obj = [[UIDatePicker alloc] init];
            /**<
             1. "en_GB" 英文24小时
             2. "zh_GB" 中文24小时
             3. "zh_CN" 中文12小时
             */
            obj.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_GB"];
            obj.datePickerMode = UIDatePickerModeDateAndTime;//设置日期格式
            
            obj;
        });
    }
    
    return _datePicker;
}

- (id)viewItems {
    if (!_viewItems) {
        _viewItems = ({
            NSMutableArray *obj = [[NSMutableArray alloc] init];
            [obj addObject:({
                WQTimeDependentCell *view = [[WQTimeDependentCell alloc] init];
                view.tag = 12;
                view.leftName.str(@"开始时间");
                view.onClick(^(WQTimeDependentCell *v) {
                    [self onclick:v];
                });
                view;
            })];
            [obj addObject:({
                WQTimeDependentCell *view = [[WQTimeDependentCell alloc] init];
                view.tag = 13;
                view.leftName.str(@"现在时间");
                view.onClick(^(WQTimeDependentCell *v) {
                    [self onclick:v];
                });
                view;
            })];
            [obj addObject:({
                WQTimeDependentCell *view = [[WQTimeDependentCell alloc] init];
                view.tag = 14;
                view.leftName.str(@"结束时间");
                view.onClick(^(WQTimeDependentCell *v) {
                    [self onclick:v];
                });
                view;
            })];
            [obj addObject:({
                UILabel *obj = [[UILabel alloc] init];
                obj.centerAlignment.bgColor(@"random").str(@"点击比较");
                obj.onClick(^(void) {
                    [self checkTime];
                });
                obj;
            })];
            [obj addObject:self.labelTimeShow];
            obj;
        });
    }
    
    return _viewItems;
}

- (id)viewItemsBg {
    if (!_viewItemsBg) {
        _viewItemsBg = ({
            UIView *obj = [[UIView alloc] init];
            obj;
        });
    }
    
    return _viewItemsBg;
}

- (id)labelTimeShow {
    if (!_labelTimeShow) {
        _labelTimeShow = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.centerAlignment.bgColor(@"random").str(@"点击计算时间");
            obj.onClick(^(void){
                RBDateTime *dateStart=[RBDateTime now];
                Log([dateStart localizedStringWithFormat:@"yyyy-MM-dd HH:mm:ss"]);
            
//                [dateStart subtractDuration:[RBDuration durationWithDays:1 hours:0 minutes:3 seconds:0 milliseconds:0]];
//                Log([dateStart localizedStringWithFormat:@"yyyy-MM-dd HH:mm:ss"]);

                
                [dateStart addYears:0 months:0 days:1 hours:0 minutes:3 seconds:0 milliseconds:0];//距离现在1天多3分钟
//                [dateStart addYears:0 months:0 days:0 hours:0 minutes:4 seconds:25 milliseconds:0];
                Log([dateStart localizedStringWithFormat:@"yyyy-MM-dd HH:mm:ss"]);
            });
            obj;
        });
    }
    
    return _labelTimeShow;
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

@end

@implementation WQTimeDependentCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.bgColor(@"random");
        self.leftName.addTo(self);
        self.rightName.addTo(self);
        
        [self.leftName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.width.mas_equalTo(90);
        }];
        [self.rightName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(self.leftName.mas_right).offset(10);
        }];
    }
    
    return self;
}

- (id)leftName {
    if (!_leftName) {
        _leftName = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.rightAlignment.fnt([UIFont boldSystemFontOfSize:13]).color(@"white");
            obj;
        });
    }
    
    return _leftName;
}

- (id)rightName {
    if (!_rightName) {
        _rightName = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.fnt([UIFont boldSystemFontOfSize:13]).color(@"white");
            obj;
        });
    }
    
    return _rightName;
}

@end
