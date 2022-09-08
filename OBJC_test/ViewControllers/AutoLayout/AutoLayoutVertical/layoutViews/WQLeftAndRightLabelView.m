//
//  WQLeftAndRightLabelView.m
//  OBJC_test
//
//  Created by liu dante on 2022/9/5.
//

#import <AVFAudio/AVFAudio.h>
#import <MediaPlayer/MediaPlayer.h>
#import "WQLeftAndRightLabelView.h"

@interface WQLeftAndRightLabelView ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) MPVolumeView *volumetView; /**<  获取系统音量视图 */
@end

@implementation WQLeftAndRightLabelView{
    CGFloat currentWidth;/**<  当前的宽度 */
    CGFloat widthRecord;/**<  记录视图的宽度 */
    CGFloat moveOffset;/**<  拖动的偏移量 */
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.bgColor(@"random");
    self.volumetView.addTo(self);
    self.viewLeft.addTo(self);
    self.labelDes.addTo(self.viewLeft);
    [self.viewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.offset(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(0);
    }];
    [self.labelDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.equalTo(self.viewLeft.mas_right).offset(-10);
    }];
    self.labelDesTest.addTo(self);
    [self.labelDesTest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(self.viewLeft.mas_right).offset(10);
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self changeToVolume:[self getVolume]];
        });
    });
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(systemVolumeDidChangeNoti:)
                                                 name:@"AVSystemController_SystemVolumeDidChangeNotification"
                                               object:nil];
}

- (void)changeToVolume:(float)volume {/**<  根据获取到的音量 更新UI */
    self.labelDes.str(@"%.0f%@", volume * 100, @"%");
    self.labelDesTest.str(@"%.0f%@", volume * 100, @"%");
    [self.viewLeft mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(volume * widthRecord);
    }];
}

- (void)systemVolumeDidChangeNoti:(NSNotification *)noti {/**<  获取当前音量 */
    float volume = [[noti.userInfo valueForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    
    [self changeToVolume:volume];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (float)getVolume {/**<  获取系统音量 */
    return self.volumeSlider.value > 0 ? self.volumeSlider.value : [[AVAudioSession sharedInstance]outputVolume];
}

- (void)layoutSubviews {
    widthRecord = self.w;
    
    self.borderRadius(self.h / 2.0);
    self.viewLeft.borderRadius(self.h / 2.0);
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    //    CGPoint speed = [pan velocityInView:self]; // 获取移动速度
    CGPoint translation = [pan translationInView:self]; // 获取移动矩阵
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        currentWidth = self.viewLeft.w;
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        currentWidth = self.viewLeft.w;
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        moveOffset = currentWidth + translation.x;
        
        if (moveOffset <= 0) {
            moveOffset = 0;
        }
        
        if (moveOffset >= widthRecord) {
            moveOffset = widthRecord;
        }
        
        [[self volumeSlider] setValue:(moveOffset / widthRecord) animated:YES];
    }
}

- (UISlider *)volumeSlider {
    UISlider *volumeSlider = nil;
    
    for (UIView *view in [self.volumetView subviews]) {
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]) {
            volumeSlider = (UISlider *)view;
            break;
        }
    }
    
    return volumeSlider;
}

#pragma mark -
#pragma mark 懒加载
- (id)labelDes {
    if (!_labelDes) {
        _labelDes = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.color(UIColor.whiteColor).fnt(12);
            obj;
        });
    }
    
    return _labelDes;
}

- (id)labelDesTest {
    if (!_labelDesTest) {
        _labelDesTest = ({
            UILabel *obj = [[UILabel alloc] init];
            obj.color(UIColor.whiteColor).fnt(12);
            obj;
        });
    }
    
    return _labelDesTest;
}

- (id)viewLeft {
    if (!_viewLeft) {
        _viewLeft = ({
            UIView *obj = [[UIView alloc] init];
            obj.bgColor(@"random");
            obj.layer.allowsEdgeAntialiasing = YES;
            obj;
        });
    }
    
    return _viewLeft;
}

- (id)volumetView {
    if (!_volumetView) {
        _volumetView = ({
            MPVolumeView *obj = [[MPVolumeView alloc]initWithFrame:XYWH(0, -44, Screen.width, 44)];
            obj.showsVolumeSlider = YES;
            obj;
        });
    }
    
    return _volumetView;
}

@end
