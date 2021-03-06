//
//  YQDetailWebController.m
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQDetailWebController.h"
#import "YQTotalDaTaModel.h"
#import "YQDetailWebData.h"
#import "YQDetailWebImageData.h"

@interface YQDetailWebController ()<UIWebViewDelegate>
@property (nonatomic , strong) YQDetailWebData *detailModel;
@property (nonatomic , weak) UIWebView *webView;
@property (nonatomic , copy) NSString *url;
@end

@implementation  YQDetailWebController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

- (void)setupUI
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 54, 44)];
    [btn setImage:[UIImage imageNamed:@"night_icon_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 63, YQSCREEN_WIDTH, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineV];
    
    //收藏
    UIButton *shoucangB = [[UIButton alloc]initWithFrame:CGRectMake(YQSCREEN_WIDTH-44-10, 20, 44, 44)];
    shoucangB.titleLabel.font = [UIFont systemFontOfSize:13];
    [shoucangB addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shoucangB];
    
//    if ([[DataBase queryWithCollect:self.dataModel.docid] isEqualToString:@"1"]) {
//        shoucangB.selected = YES;
//        [shoucangB setTitle:@"已收藏" forState:UIControlStateNormal];
//        [shoucangB setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    }else{
        [shoucangB setTitle:@"收藏" forState:UIControlStateNormal];
        [shoucangB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }
    
    //分享
    UIButton *fenxiangB = [[UIButton alloc]initWithFrame:CGRectMake(YQSCREEN_WIDTH-20-88, 20, 44, 44)];
    [fenxiangB setTitle:@"分享" forState:UIControlStateNormal];
    [fenxiangB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fenxiangB.titleLabel.font = [UIFont systemFontOfSize:13];
    //[fenxiangB addTarget:self action:@selector(fenxiang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fenxiangB];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.backgroundColor = [UIColor whiteColor];
    webView.y = 64;
    webView.height = YQSCREEN_HEIGHT - 64;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)setupData
{
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.dataModel.docid];
    self.url = url;
    IMP_BLOCK_SELF(YQDetailWebController);
    [[YQRequestTool shareRequestTool] setupRequestWithParameters:nil getPath:url sussce:^(id responseObject) {
        
        block_self.detailModel = [YQDetailWebData detailWithDict:responseObject[block_self.dataModel.docid]];
        
        [block_self showInWebView];
    } failure:^(id error) {
        
    }];
}


- (void)showInWebView
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"Detail.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
    
}

- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailModel.ptime];
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    // 遍历img
    for (YQDetailWebImageData *detailImgModel in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

#pragma mark - 将发出通知时调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"sx:src="];
    if (range.location != NSNotFound) {
        NSInteger begin = range.location + range.length;
        NSString *src = [url substringFromIndex:begin];
        [self savePictureToAlbum:src];
        return NO;
    }
    return YES;
}


- (void)savePictureToAlbum:(NSString *)src
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSURLCache *cache =[NSURLCache sharedURLCache];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:src]];
        NSData *imgData = [cache cachedResponseForRequest:request].data;
        UIImage *image = [UIImage imageWithData:imgData];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
//    if (error != NULL){
//        [MBProgressHUD showError:@"下载失败"];
//    }else{
//        [MBProgressHUD showSuccess:@"保存成功"];
//    }
    
}


#pragma mark - 收藏
- (void)shoucang:(UIButton *)btn
{
    btn.selected = !btn.selected;

}





- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

@end
