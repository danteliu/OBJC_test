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
@property (nonatomic, strong) NSMutableArray <UIView *> *viewItems;/**<  <#属性注释#> */

@property (nonatomic, strong) UIDatePicker *datePicker;/**<  时间选择器 */
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
    WQTimeDependentCell *before = [self.viewItemsBg viewWithTag:12];
    WQTimeDependentCell *cur = [self.viewItemsBg viewWithTag:13];
    WQTimeDependentCell *last = [self.viewItemsBg viewWithTag:14];
    
    //    Log(before.rightName.text);
    //    Log(cur.rightName.text);
    //    Log(last.rightName.text);
    
    NSDate *dateBefore = [RBDateTime dateTimeByParsingString:before.rightName.text withFormat:@"YYYY-MM-dd HH:mm:ss"].NSDate;
    NSDate *dateCur = [RBDateTime dateTimeByParsingString:cur.rightName.text withFormat:@"YYYY-MM-dd HH:mm:ss"].NSDate;
    NSDate *dateLast = [RBDateTime dateTimeByParsingString:last.rightName.text withFormat:@"YYYY-MM-dd HH:mm:ss"].NSDate;
    
    //    Log(dateBefore);
    //    Log(dateCur);
    //    Log(dateLast);
    
    /**<
     NSComparisonResult result = [dateBefore compare:dateLast];
     if (result == NSOrderedDescending) {
     NSLog(@"Date1 大于 Date2");
     } else if (result == NSOrderedAscending) {
     NSLog(@"Date1 小于 Date2");
     } else {
     NSLog(@"Date1 Date2 相等");
     }
     */
    
    
    NSComparisonResult result = [dateBefore compare:dateLast];//开始时间和结束时间对比
    
    if (result == NSOrderedDescending) {
        Log(@"开始时间大于结束时间");
    } else if (result == NSOrderedAscending) {
        NSComparisonResult result = [dateBefore compare:dateCur];//开始时间和现在时间对比
        
        if (result == NSOrderedDescending) {
            Log(@"活动已开始");
            [self pleaseInsertStarTimeo:cur.rightName.text andInsertEndTime:last.rightName.text];
        } else if (result == NSOrderedAscending) {
            Log(@"活动未开始");
            [self pleaseInsertStarTimeo:before.rightName.text andInsertEndTime:cur.rightName.text];
        } else {
            Log(@"活动开始");
        }
    } else {
        Log(@"异常:开始时间等于结束时间");
    }
}

- (void)pleaseInsertStarTimeo:(NSString *)time1 andInsertEndTime:(NSString *)time2 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];// 1.将时间转换为date
    
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    NSCalendar *calendar = [NSCalendar currentCalendar];// 2.创建日历
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];// 3.利用日历对象比较两个时间的差值
    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);// 4.输出结果
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
