//
//  ScanCodeVC.m
//  CMCCSmartPark
//
//  Created by liu dante on 2022/4/18.
//

#import "ScanCodeVC.h"

@interface ScanCodeVC ()<AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
#define ScanY 150           //扫描区域y
#define ScanWidth 250       //扫描区域宽度
#define ScanHeight 250      //扫描区域高度
@property(nonatomic,strong) AVCaptureDevice *device;/**<  创建相机 */
@property(nonatomic,strong) AVCaptureDeviceInput *input;/**<  创建输入设备 */
@property(nonatomic,strong) AVCaptureMetadataOutput *output;/**<  创建输出设备 */
@property(nonatomic,strong) AVCaptureSession *session;/**<  创建捕捉类 */
@property(strong,nonatomic) AVCaptureVideoPreviewLayer *preview;/**<  视觉输出预览层 */

@property (nonatomic, strong) UIView *centerBgView;/**<  中间白色区域 */

@property (nonatomic, strong) UIView * topView;/**<  顶部maskView */
@property (nonatomic, strong) UIView * leftView;/**<  左 maskView */
@property (nonatomic, strong) UIView * rightView;/**<  右maskView */
@property (nonatomic, strong) UIView * bottomView;/**<  底部maskView */

@property (nonatomic, strong) UIView * noticeLab;/**<  提示语 */
@property (nonatomic, strong) UIImageView * bottomImg;/**<  未定义 */
@property (nonatomic, strong) UILabel *lightImg;/**< 灯 开关 */
@property (nonatomic, strong) UIImageView *line;/**< 线条 */

@end

@implementation ScanCodeVC {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
- (void)setUpUI {
//    [self changeToTitle:@"扫码"];
//    [self addLeftBarButtonItems:@[self.backItem]];
//    [self setNavBgAlpha:0];
    [self capture];
    
}
- (void)setUIConstraints {
    
}
#pragma mark - 初始化扫描设备
- (void)capture
{
    //如果是模拟器返回（模拟器获取不到摄像头）
    if (TARGET_IPHONE_SIMULATOR) {
        return;
    }
    // 1.这里可以设置多种输出类型,这里必须要保证session层包括输出流
    // 2.必须要当前项目访问相机权限必须通过,所以最好在程序进入当前页面的时候进行一次权限访问的判断
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus ==AVAuthorizationStatusRestricted|| authStatus ==AVAuthorizationStatusDenied) {
        Alert.title(@"提示").message(@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“智慧园区”打开相机访问权限").action(@"确定", ^{
            [self.navigationController popViewControllerAnimated:YES];
        }).show();
        return;
    }
    
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    self.centerBgView.addTo(self.view);
    [self.centerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);//居中
        make.left.offset(60);
        make.right.offset(-60);
        make.height.equalTo(self.centerBgView.mas_width);
    }];
    [self.view layoutIfNeeded];
    //设置扫码区域
    [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification * _Nonnull note) {
        self.output.rectOfInterest=[self.preview metadataOutputRectOfInterestForRect:self.centerBgView.frame];
    }];
    
    [self addMaskView];
    [self.session startRunning];//开始扫描
}

#pragma mark - 实现代理方法, 完成二维码扫描
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        [self.session stopRunning];/**<  停止扫描 */
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        Log(metadataObject.stringValue);
        if (self.scanComplete) {
            self.scanComplete(metadataObject.stringValue);
        }
    }
}

-(id)centerBgView {
    if (!_centerBgView) {
        _centerBgView=({
            UIView *obj=View.bgColor(@"white,0");
            obj.layer.contents=(__bridge id _Nullable)(Img(@"public_erweimakuang").CGImage);
            obj;
        });
    }
    return _centerBgView;
}
#pragma mark -
#pragma mark AVFoundation 初始化
-(id)device {
    if (!_device) {
        _device=({
            AVCaptureDevice *obj = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];//初始化基础"引擎"Device
            obj;
        });
    }
    return _device;
}
-(id)input {
    if (!_input) {
        _input=({
            AVCaptureDeviceInput *obj = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];//初始化输入流 Input,并添加Device
            obj;
        });
    }
    return _input;
}
-(id)output {
    if (!_output) {
        _output=({
            AVCaptureMetadataOutput *obj = [[AVCaptureMetadataOutput alloc] init];//初始化输出流Output
            //设置输出流的相关属性
            // 确定输出流的代理和所在的线程,这里代理遵循的就是上面我们在准备工作中提到的第一个代理,至于线程的选择,建议选在主线程,这样方便当前页面对数据的捕获.
            [obj setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            //            obj.rectOfInterest = CGRectMake(0,0,1,1);//设置扫描区域的大小 rectOfInterest  默认值是CGRectMake(0, 0, 1, 1) 按比例设置
            obj;
        });
    }
    return _output;
}
-(id)session {
    if (!_session) {
        _session=({
            AVCaptureSession*obj = [[AVCaptureSession alloc] init];// 初始化session
            /*
             // AVCaptureSession 预设适用于高分辨率照片质量的输出
             AVF_EXPORT NSString *const AVCaptureSessionPresetPhoto NS_AVAILABLE(10_7, 4_0) __TVOS_PROHIBITED;
             // AVCaptureSession 预设适用于高分辨率照片质量的输出
             AVF_EXPORT NSString *const AVCaptureSessionPresetHigh NS_AVAILABLE(10_7, 4_0) __TVOS_PROHIBITED;
             // AVCaptureSession 预设适用于中等质量的输出。 实现的输出适合于在无线网络共享的视频和音频比特率。
             AVF_EXPORT NSString *const AVCaptureSessionPresetMedium NS_AVAILABLE(10_7, 4_0) __TVOS_PROHIBITED;
             // AVCaptureSession 预设适用于低质量的输出。为了实现的输出视频和音频比特率适合共享 3G。
             AVF_EXPORT NSString *const AVCaptureSessionPresetLow NS_AVAILABLE(10_7, 4_0) __TVOS_PROHIBITED;
             */
            [obj setSessionPreset:AVCaptureSessionPresetHigh];// 设置session类型,AVCaptureSessionPresetHigh 是 sessionPreset 的默认值。
            if ([obj canAddInput:self.input]) {// 添加输入流
                [obj addInput:self.input];
            }
            
            if ([obj canAddOutput:self.output]) {// 添加输出流
                [obj addOutput:self.output];
                
                NSMutableArray *metadataObjectTypes = [NSMutableArray array];//扫描格式
                [metadataObjectTypes addObjectsFromArray:@[
                    AVMetadataObjectTypeQRCode,
                    AVMetadataObjectTypeEAN13Code,
                    AVMetadataObjectTypeEAN8Code,
                    AVMetadataObjectTypeCode128Code,
                    AVMetadataObjectTypeCode39Code,
                    AVMetadataObjectTypeCode93Code,
                    AVMetadataObjectTypeCode39Mod43Code,
                    AVMetadataObjectTypePDF417Code,
                    AVMetadataObjectTypeAztecCode,
                    AVMetadataObjectTypeUPCECode,
                ]];
                
                if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {// >= ios 8
                    [metadataObjectTypes addObjectsFromArray:@[
                        AVMetadataObjectTypeInterleaved2of5Code,
                        AVMetadataObjectTypeITF14Code,
                        AVMetadataObjectTypeDataMatrixCode
                    ]];
                }
                self.output.metadataObjectTypes = metadataObjectTypes;//设置扫描格式
            }
            obj;
        });
    }
    return _session;
}
-(id)preview {
    if (!_preview) {
        _preview=({
            AVCaptureVideoPreviewLayer *obj=[AVCaptureVideoPreviewLayer layerWithSession:self.session];
            /**
             设置Video Gravity,顾名思义就是视频播放时的拉伸方式,默认是AVLayerVideoGravityResizeAspect
             AVLayerVideoGravityResizeAspect 保持视频的宽高比并使播放内容自动适应播放窗口的大小。
             AVLayerVideoGravityResizeAspectFill 和前者类似，但它是以播放内容填充而不是适应播放窗口的大小。最后一个值会拉伸播放内容以适应播放窗口.
             */
            obj.videoGravity =AVLayerVideoGravityResizeAspectFill;//因为考虑到全屏显示以及设备自适应,这里我们采用fill填充
            obj.frame = CGRectMake(0, 0, Screen.width, Screen.height);//设置展示平台的frame
            
            obj;
        });
    }
    return _preview;
}
#pragma mark -
#pragma mark 添加 mask
-(void)addMaskView {
    self.topView.addTo(self.view);
    self.leftView.addTo(self.view);
    self.rightView.addTo(self.view);
    self.bottomView.addTo(self.view);
    
    self.noticeLab.addTo(self.view);
    self.bottomImg.addTo(self.view);
    self.lightImg.addTo(self.view);
    self.line.addTo(self.centerBgView);
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.equalTo(self.centerBgView.mas_top).offset(0);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(0);
        make.left.offset(0);
        make.right.equalTo(self.centerBgView.mas_left).offset(0);
        make.bottom.equalTo(self.centerBgView.mas_bottom).offset(0);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(0);
        make.right.offset(0);
        make.left.equalTo(self.centerBgView.mas_right).offset(0);
        make.bottom.equalTo(self.centerBgView.mas_bottom).offset(0);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerBgView.mas_bottom).offset(0);
        make.left.bottom.right.offset(0);
    }];
    
    [self.noticeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(self.topView.mas_bottom).offset(-16);
        make.size.mas_equalTo(CGSizeMake(156, 20));
    }];
    
    [self.bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.offset(0);
        make.size.mas_equalTo(CGSizeMake(95, 120));
    }];
    
    [self.lightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        //        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(self.bottomView.mas_top).offset(16);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.mas_equalTo(2);
    }];
    
    
}
-(NSString *)getMaskColor {
    return @"black,0.3";
}
-(id)topView {
    if (!_topView) {
        _topView=({
            UIView *obj=View.bgColor([self getMaskColor]);
            obj;
        });
    }
    return _topView;
}

-(id)leftView {
    if (!_leftView) {
        _leftView=({
            UIView *obj=View.bgColor([self getMaskColor]);
            obj;
        });
    }
    return _leftView;
}
-(id)rightView {
    if (!_rightView) {
        _rightView=({
            UIView *obj=View.bgColor([self getMaskColor]);
            obj;
        });
    }
    return _rightView;
}
-(id)bottomView {
    if (!_bottomView) {
        _bottomView=({
            UIView *obj=View.bgColor([self getMaskColor]);
            obj;
        });
    }
    return _bottomView;
}
-(id)noticeLab {
    if (!_noticeLab) {
        _noticeLab=({
            UILabel *obj=Label.fnt(12).centerAlignment.color(@"white").borderRadius(5).bgColor(@"#000000,0.6").str(@"请将条码/二维码放入框内");;
            obj;
        });
    }
    return _noticeLab;
}
-(id)bottomImg {
    if (!_bottomImg) {
        _bottomImg=({
            UIImageView *obj=ImageView.aspectFill.img(@"public_toumingtubiao");
            obj;
        });
    }
    return _bottomImg;
}
-(id)lightImg {
    if (!_lightImg) {
        _lightImg=({
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            __block BOOL isTurnON=NO;
            UILabel *obj=Label.str(@"开灯").color(UIColor.whiteColor).onClick(^(UILabel *subImg){
                if ([device hasTorch]) {
                    if (isTurnON) {
                        subImg.str(@"开灯");
                        [device lockForConfiguration:nil];
                        [device setTorchMode: AVCaptureTorchModeOff];//关
                        [device unlockForConfiguration];
                    }else{
                        subImg.str(@"关灯");
                        [device lockForConfiguration:nil];
                        [device setTorchMode: AVCaptureTorchModeOn];//开
                        [device unlockForConfiguration];
                    }
                    isTurnON = !isTurnON;
                }
            });
            obj;
        });
    }
    return _lightImg;
}
-(id)line {
    if (!_line) {
        _line=({
            UIImageView *obj=ImageView.img(@"white").borderRadius(1);
            POPBasicAnimation *lineAnimation=({
                POPBasicAnimation *animation= [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
                animation.duration=5;
                animation.repeatForever=YES;
                animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                animation.fromValue=@(-2);
                animation.toValue=@(self.centerBgView.h);
                animation;
            });
            [obj.layer pop_addAnimation:lineAnimation forKey:@"lineAnimation"];
            obj;
        });
    }
    return _line;
}
@end

@implementation ScancodeModel

@end
