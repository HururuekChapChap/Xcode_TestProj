//
//  ViewController.h
//  KxMemoObjc
//
//  Created by yoon tae soo on 2021/01/17.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *qrCodeBtn;


@end

