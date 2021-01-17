//
//  ViewController.m
//  KxMemoObjc
//
//  Created by yoon tae soo on 2021/01/17.
//

#import "ViewController.h"
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#import <QRCodeReader.h>

@interface ViewController () <QRCodeReaderDelegate> // 프로토콜 설정 방법

//멤버 변수 설정
{
    QRCodeReaderViewController *qrCodeVC;
    QRCodeReader *reader;
    
    NSString *result;
}


@end


//QRCode OpenSource : https://github.com/yannickl/QRCodeReaderViewController#usage
@implementation ViewController

//View가 로드 되었을 때
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    result = @"https://naver.com";
    //웹 뷰를 띄우는 방법 
    NSURL *websiteUrl = [NSURL URLWithString:result];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    
    [self.webView loadRequest:urlRequest];
    
    //QRCode 버튼 실행
    [self.qrCodeBtn addTarget:self action:@selector(qrcodeReaderLaunch) forControlEvents: UIControlEventTouchUpInside];
    
    [self.qrCodeBtn layer].borderColor = [UIColor blueColor].CGColor;
    [self.qrCodeBtn layer].borderWidth = 3;
    [self.qrCodeBtn layer].cornerRadius = 10;
    [self.qrCodeBtn layer].backgroundColor = [UIColor yellowColor].CGColor;
    
    [self setQRCodeVC];
    
}

- (void) setQRCodeVC{
    // Create the reader object
    reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];

    // Instantiate the view controller
    qrCodeVC = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];

    // Set the presentation style
    qrCodeVC.modalPresentationStyle = UIModalPresentationFormSheet;

    // Define the delegate receiver
    qrCodeVC.delegate = self;

    // Or use blocks
//    [reader setCompletionWithBlock:^(NSString *resultAsString) {
//      NSLog(@"%@", resultAsString);
//    }];
}

- (void) qrcodeReaderLaunch {
    NSLog(@"Main View Controller - qrCodeReaderLaunched");
    
    [self presentViewController:qrCodeVC animated:YES completion:NULL];
}

#pragma mark - QRCodeReader Delegate Methods

//QRCode가 호출 될 때
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    
    NSLog(@"QRCode 인식 성공!");
  [self dismissViewControllerAnimated:YES completion:^{
    NSLog(@"QR코드 결과 : %@", result);
      self->result = result;
  }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    
    NSLog(@"QR코드 인식 실패");
  [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
