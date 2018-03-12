//
//  RQRCodeViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/12.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WBSeparateButton.h"
#import "RBlueToothManager.h"
#import "WBAPIManager.h"

@interface RQRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    CAShapeLayer *cropLayer;
    
    CGRect scanRect;
    CGFloat kLeft;
    CGFloat kTop;
}
@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, strong) UIImageView * line;
@property (nonatomic, strong) WBSeparateButton *lightBtn;
@end

@implementation RQRCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    kTop =  (SCREEN_HEIGHT-220)/2 - (__IPHONEX_?88:64);
    kLeft = (SCREEN_WIDTH-220)/2;
    scanRect = CGRectMake(kLeft, kTop, 220, 220);
    self.navigationItem.title = @"扫码";
    [self configView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configView{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:scanRect];
    imageView.image = [[UIImage imageNamed:@"image_scan_dec"] resizableImageWithCapInsets:UIEdgeInsetsMake(80, 80, 80, 80) resizingMode:UIImageResizingModeStretch];
    [self.view addSubview:imageView];
    
    [self.view addSubview:self.lightBtn];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(kLeft, kTop+10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self setCropRect:scanRect];
    
    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0.3];
    
}

-(void)animation1
{
//    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(kLeft, kTop+10+2*num, 220, 2);
        if (2*num == 200) {
            upOrdown = YES;

            num = 0;
            _line.frame = CGRectMake(kLeft, kTop, 220, 2);
        }
//    }
//    else {
//        num --;
//        _line.frame = CGRectMake(kLeft, kTop+10+2*num, 220, 2);
//        if (num == 0) {
//            upOrdown = NO;
//        }
//    }
    
}


- (void)setCropRect:(CGRect)cropRect{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    
    
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
}

- (void)setupCamera
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = kTop/SCREEN_HEIGHT;
    CGFloat left = kLeft/SCREEN_WIDTH;
    CGFloat width = 220/SCREEN_WIDTH;
    CGFloat height = 220/SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]){
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output]){
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
}

#pragma mark - Event
- (void)lightClick
{
    self.lightBtn.selected = !self.lightBtn.isSelected;
    
    if(_device.hasTorch){
        [_device lockForConfiguration:nil];
        [_device setTorchMode: self.lightBtn.selected?AVCaptureTorchModeOn:AVCaptureTorchModeOff];
        [_device unlockForConfiguration];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;    
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"扫描结果：%@",stringValue);
        
        NSArray *arry = metadataObject.corners;
        for (id temp in arry) {
            NSLog(@"%@",temp);
        }

        BOOL vaild = YES;
        if(vaild){
            if (_session != nil && timer != nil) {
                [_session startRunning];
                [timer setFireDate:[NSDate date]];
            }
            [[RBlueToothManager manager] connectToLock:stringValue complete:^(BOOL success) {
                if(success){
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [WBLoadingView showErrorStatus:@"认证失败"];
                }
            }];
        }
        else{
//            if([WBAPIManager sharedManager].servicePhoneNum.isNotEmpty){
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法识别" message:@"即将呼叫客服，是否现在呼叫?" preferredStyle:UIAlertControllerStyleAlert];
//                [alert addAction:[UIAlertAction actionWithTitle:@"手动输入锁序号" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                    [self.navigationController popViewControllerAnimated:YES];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationManualInputSerialNum object:nil];
//                }]];
//                [alert addAction:[UIAlertAction actionWithTitle:@"呼叫客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[WBAPIManager sharedManager].servicePhoneNum]]];
//                }]];
//                [self presentViewController:alert animated:YES completion:nil];
//            }
        }
        
    } else {
        NSLog(@"无扫描信息");
        return;
    }
}

#pragma mark - Getter
- (WBSeparateButton *)lightBtn
{
    if(!_lightBtn){
        _lightBtn = [[WBSeparateButton alloc] initWithFrame:CGRectMake((self.view.width-90)/2, self.view.height-180, 90, 80)];
        _lightBtn.imageRect = CGRectMake(20, 0, 50, 50);
        _lightBtn.labelRect = CGRectMake(0, 60, 90, 15);
        _lightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _lightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_lightBtn setImage:[UIImage imageNamed:@"diantong_off"] forState:UIControlStateNormal];
        [_lightBtn setImage:[UIImage imageNamed:@"diantong_on"] forState:UIControlStateSelected];
        [_lightBtn setTitle:@"打开手电筒" forState:UIControlStateNormal];
        [_lightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_lightBtn setTitle:@"关闭手电筒" forState:UIControlStateSelected];
        [_lightBtn setTitleColor:HEX_RGB(0xFFE17E) forState:UIControlStateSelected];
        [_lightBtn addTarget:self action:@selector(lightClick) forControlEvents:UIControlEventTouchDown];
    }
    return _lightBtn;
}
@end
