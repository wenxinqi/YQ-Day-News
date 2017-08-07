//
//  YQNewsViewController.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/20.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQNewsViewController.h"
#import "YQSocialViewController.h"


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
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YQSCREEN_WIDTH, 64)];
    
    titleView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha: 1];
    
    [self.view addSubview:titleView];
    
//添加topSquareImage
    UIImageView *squareImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_navigation_square"]];
    squareImageV.frame = CGRectMake(YQSCREEN_WIDTH - 30, 30, YQTopSquareWH, YQTopSquareWH);
    
//    给imagev添加一个点击事件
    [squareImageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSquareImageV)]];
    squareImageV.userInteractionEnabled = YES;
    [titleView addSubview:squareImageV];
    
//往titleView中添加titleScrollview
    //当一个弱类型的变量被创建分配内存后，会立马被释放
    UIScrollView *titleScrollview = [[UIScrollView alloc] init];
    //    给titlescrollview添加样式
    titleScrollview.frame = CGRectMake(0, 20, self.view.bounds.size.width - 39, 44);
    self.titleScrollView = titleScrollview;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
   
    [titleView addSubview:titleScrollview];

    
//    往titleScrollview中添加button
    //创建一个数组存放btn的textlabel
    CGFloat btnX ;
    CGFloat btnW = 72;
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
        btn.userInteractionEnabled = YES;
        
//将btn添加到titlescrollview中,让titleScrollview在最上面
        [self.titleScrollView insertSubview:btn belowSubview:self.titleScrollView];
        
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

//tapSquareImageV
- (void)tapSquareImageV
{
    NSLog(@"tapclick");
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
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * YQSCREEN_WIDTH, 0);
    self.contentScrollView.pagingEnabled = YES;
    
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
    offset.x = index * YQSCREEN_WIDTH;
    
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
    
//    给titleScrollview添加偏移量
    CGPoint titleOffset = scrollView.contentOffset;
    NSInteger i = offsetX / YQSCREEN_WIDTH;
    if (i >= 3 && i <= 5) {
        titleOffset.x = (i - 2) * 72;
        [self.titleScrollView setContentOffset:titleOffset animated:YES];
    }else if (i >= 5){
        titleOffset.x = 3 * 72;
        [self.titleScrollView setContentOffset:titleOffset animated:YES];
    }
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
   [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //标签栏内的按钮随着滚动
    NSInteger index = self.contentScrollView.contentOffset.x / scrollView.width;
    [self btnClick:self.titleScrollView.subviews[index]];
}
@end
