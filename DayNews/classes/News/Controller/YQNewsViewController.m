//
//  YQNewsViewController.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/20.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQNewsViewController.h"
#import "YQTitleView.h"
#import "YQSocialViewController.h"

#define  YQScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface YQNewsViewController ()<UIScrollViewDelegate>
//标题scrollview
@property (nonatomic , weak) UIScrollView *titleScrollView;
//内容scrollveiw
@property (nonatomic , weak) UIScrollView *contentScrollView;
//被选中的button
@property (nonatomic , weak) UIButton *selectedBtn;

@end

@implementation YQNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    创建子控制器
    [self setupChildVc];
    //创建头部视图
    [self setupTitleView];
    
    //创建内容视图
    [self setupContentView];
}

#pragma mark 创建子控制器
- (void)setupChildVc
{
    //    向contentScrollView添加子控制器
    YQSocialViewController *social = [[YQSocialViewController alloc] init];
    [self addChildViewController:social];
    
    YQSocialViewController *social1 = [[YQSocialViewController alloc] init];
    [self addChildViewController:social1];

    YQSocialViewController *social2 = [[YQSocialViewController alloc] init];
    [self addChildViewController:social2];

    YQSocialViewController *social3 = [[YQSocialViewController alloc] init];
    [self addChildViewController:social3];

    YQSocialViewController *social4 = [[YQSocialViewController alloc] init];
    [self addChildViewController:social4];

    YQSocialViewController *social5 = [[YQSocialViewController alloc] init];
    [self addChildViewController:social5];

    YQSocialViewController *social6 = [[YQSocialViewController alloc] init];
    [self addChildViewController:social6];
    
    YQSocialViewController *social7 = [[YQSocialViewController alloc] init];
    [self addChildViewController:social7];
    
    YQSocialViewController *social8 = [[YQSocialViewController alloc] init];
    [self addChildViewController:social8];

}

/**
 1、给btn添加点击事件，content的发生位移
 */
- (void) setupTitleView{
    //自定义一个titleview添加到news的头部
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    创建titleview
    YQTitleView *titleView = [YQTitleView titleVeiw];
    //    将titleview添加到viewcontroller上，设置frame
    titleView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    [self.view addSubview:titleView];
    
    
    //往titleView中添加titleScrollview
    //当一个弱类型的变量被创建分配内存后，会立马被释放
    UIScrollView *titleScrollview = [[UIScrollView alloc] init];
    //    给titlescrollview添加样式
    titleScrollview.frame = CGRectMake(0, 20, self.view.bounds.size.width - 39, 44);
    self.titleScrollView = titleScrollview;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    [titleView addSubview:titleScrollview];
    
//    让titleScrollView可以和用户进行交互
    self.titleScrollView.userInteractionEnabled = YES;
    
//    往titleScrollview中添加button
    //创建一个数组存放btn的textlabel
    CGFloat btnX ;
    CGFloat btnW = 80;
    CGFloat btnH = 44;
    NSArray *btnNames = @[@"社会",@"国内",@"国际",@"娱乐",@"体育",@"科技",@"奇闻趣事",@"生活健康"];
    
    for (NSInteger i = 0; i < btnNames.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
       
        [btn setTitle:btnNames[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tintColor = [UIColor redColor];
        btnX = btnW * i;
//        设置btn的frame
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        
        //将btn添加到titlescrollview中
        [self.titleScrollView addSubview:btn];
        
        //第一个按钮默认为点击状态
        if (i == 0) {
            btn.enabled = NO;
//            当前被选中的btn
            self.selectedBtn = btn;
        }
    }
    
    //设置titleScrollView的contentsize
    self.titleScrollView.contentSize = CGSizeMake(btnW * btnNames.count, 0);
    
    
}

- (void) setupContentView
{
    //创建一个scrollveiw
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    //设置contentV的属性
    contentScrollView.frame = CGRectMake(0, 64, self.view.width, self.view.height - 108);
//    contentScrollV.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    
#warning 遵守代理才会执行代理方法
    contentScrollView.delegate = self;
    
//    设置contentScrollView的contentsize,设置哪个为0，则这个方向上不能滚动
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * YQScreenWidth, 0);
//    self.contentScrollView.pagingEnabled = YES;
    
//    默认第一个
    [self scrollViewDidEndScrollingAnimation:_contentScrollView];
}

/**
 点击btn时根据btn的tag值，contentScrollveiw的的内容发生偏移
 当发生偏移后scrollveiw的代理方法中传入偏移量，根据偏移量设置titleScrollview的偏移量

 @param btn 传入的当前被点击的button
 */
- (void)btnClick:(UIButton *)btn
{
//    修改按钮的状态
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;

//    contentScrollview的偏移量
    NSInteger index = btn.tag;
    
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * YQScreenWidth;
    
    [self.contentScrollView setContentOffset:offset animated:YES];
    
}

#pragma mark scrollviewDelegate
//当scrollview停止滚动的时候调用

/**
 停止滚动动画的时候，使用scrollview传入的偏移量，进行上下文的联动
  */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    一些常量
    CGFloat width = scrollView.width;
    CGFloat height = scrollView.height;
    CGFloat offsetX = scrollView.contentOffset.x;
   
    NSInteger index = offsetX / scrollView.width ;
    
//    将子控制器的view添加到contentScrollview中
    UITableViewController *willShowVc = self.childViewControllers[index];
    
    
//    当当前的view已经被加载过，则直接返回；
    if ([willShowVc isViewLoaded]) return;
    
//    设置willshowVc的frame
   
    willShowVc.view.frame = CGRectMake(offsetX,0,width,height);
     
    [self.contentScrollView addSubview:willShowVc.view];
}

//只要scrollview滚动就会调用这个方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

//当srollview开始拉曳的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

}
@end
