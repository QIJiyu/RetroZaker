//
//  QrCodeViewController.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/4/12.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "QrCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

static const char *kScanQRCodeQueueName = "ScanQRCodeQueue";

@interface QrCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) AVCaptureMetadataOutput *captureMetadataOutput;
@property (nonatomic) BOOL lastResult;
@property (nonatomic) CGRect rectOfInterest;

@end

@implementation QrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self startReading];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createControl];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self stopReading];
    [super viewDidDisappear:animated];
}

- (void)createUI {
//    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    UIImage *image = [UIImage imageNamed:@"qrcode_scan_bg_Green_iphone5"];
//    backImageView.image = image;
//    backImageView.clipsToBounds=YES;
//    backImageView.userInteractionEnabled = YES;
//    [self.view addSubview:backImageView];
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64)];
    maskView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    [self.view addSubview:maskView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    [maskPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(30, 100 - 64, KSCREEN_WIDTH - 60, 300) cornerRadius:1] bezierPathByReversingPath]];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskView.layer.mask = maskLayer;
    [self.view.layer addSublayer:maskView.layer];
}

- (BOOL)startReading
{
    /*
    // 获取 AVCaptureDevice 实例
    NSError * error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    // 创建会话
    _captureSession = [[AVCaptureSession alloc] init];
    // 添加输入流
    [_captureSession addInput:input];
    // 初始化输出流
    _captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    // 添加输出流
    [_captureSession addOutput:_captureMetadataOutput];
    // 创建dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    [_captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [_captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // 创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.view.layer.bounds];
    // 设置扫描区域
    CGRect intertRect = [_videoPreviewLayer metadataOutputRectOfInterestForRect:CGRectMake(30, 100 - 64, KSCREEN_WIDTH - 60, 300)];
    CGRect layerRect = [_videoPreviewLayer rectForMetadataOutputRectOfInterest:intertRect];
    NSLog(@"%@,  %@",NSStringFromCGRect(intertRect),NSStringFromCGRect(layerRect));
    _captureMetadataOutput.rectOfInterest = intertRect;
    [self.view.layer addSublayer:_videoPreviewLayer];
    // 开始会话
    [_captureSession startRunning];
    */
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    
    self.captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    [_captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_captureSession canAddInput:captureInput]) {
        
        [_captureSession addInput:captureInput];
        
    }
    
    if ([_captureSession canAddOutput:_captureMetadataOutput]) {
        
        [_captureSession addOutput:_captureMetadataOutput];
        
    }
    
    _captureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    CGRect rect = CGRectMake(30, 100, KSCREEN_WIDTH - 60, 300);
    
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    
    previewLayer.frame = self.view.bounds;
    
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.view.layer addSublayer:previewLayer];
    CGRect intertRect = [previewLayer metadataOutputRectOfInterestForRect:rect];
    
    CGRect layerRect = [previewLayer rectForMetadataOutputRectOfInterest:intertRect];
    
    NSLog(@"%@,  %@",NSStringFromCGRect(intertRect),NSStringFromCGRect(layerRect));
    
    _captureMetadataOutput.rectOfInterest = intertRect;
    
    [_captureSession startRunning];

    return YES;
}

- (void)stopReading
{
    // 停止会话
    [_captureSession stopRunning];
    _captureSession = nil;
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
            BOOL isURL = [self checkURL:result];
            if (isURL) {
                [self alertShowMessage:result];
            } else {
                
            }
        } else {
            ZAKER_Log(@"不是二维码");
        }
//        [self performSelectorOnMainThread:@selector(reportScanResult:) withObject:result waitUntilDone:NO]
    }
}

- (void)alertShowMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"可能存在风险, 是否打开此链接?" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"打开链接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:message]];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)checkURL:(NSString*) URL {
    NSString *pattern =@"http+:[^\\s]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:URL];
    return isMatch;
}

- (void)reportScanResult:(NSString *)result
{
//    [self stopReading];
    if (!_lastResult) {
        return;
    }
    _lastResult = NO;
    // 以下处理了结果，继续下次扫描
    _lastResult = YES;
}

- (void)createControl {
    self.navigationItem.title = @"二维码/条形码";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.translucent = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
