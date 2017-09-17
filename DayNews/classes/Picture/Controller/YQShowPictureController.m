//
//  YQShowPictureController.m
//  DayNews
//
//  Created by 奇奇 on 2017/9/16.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQShowPictureController.h"
#import <Photos/Photos.h>
#import "YQPictureData.h"

@interface YQShowPictureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic , strong) UIImageView *imageView;

@end

@implementation YQShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加一个imageview
    [self setupImageView];
    
    
}
- (void)setupImageView{
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    
    // 图片尺寸
    CGFloat pictureW = YQSCREEN_WIDTH;
    CGFloat pictureH = pictureW * self.pictureData.image_height / self.pictureData.image_width;
    
    if (pictureH > YQSCREEN_HEIGHT) { // 图片显示高度超过一个屏幕, 需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = YQSCREEN_HEIGHT * 0.5;
    }
    
    // 下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.pictureData.small_url] placeholderImage:nil options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        YQLog(@"下载完成");
    }];
    self.imageView = imageView;
    
//    给图片添加一个捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    [self.imageView addGestureRecognizer:pinch];
}

//捏合手势方法实现
- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    
    pinch.scale = 1;
}
- (IBAction)saveImageToAblum {
    
    //    点击保存按钮获得访问权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            YQLog(@"Authorized");
        }else{
            YQLog(@"Denied or Restricted");
        }
    }];
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self,@selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

//保存完成后的操作
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *) error contextInfo: (void *) contextInfo
{
    if (error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存图片" message:@"保存失败" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存图片" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }
}
//点击返回
- (IBAction)back {
    
    [YQApplicationWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
