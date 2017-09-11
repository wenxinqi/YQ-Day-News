//
//  YQRefreshGifController.m
//  Pods
//
//  Created by 奇奇 on 2017/8/27.
//
//

#import "YQRefreshGifController.h"

@implementation YQRefreshGifController

//重写父类方法，当调用该方法时会先从子类寻找同名方法
- (void)prepare
{
    [super prepare];
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSInteger i = 1 ; i <= 60 ; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%ld",(long)i]];
        [idleImages addObject:image];
    }
    
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    NSMutableArray *refreshImages = [NSMutableArray array];
    for (NSInteger i = 1 ; i <= 3 ; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
        [refreshImages addObject:image];
    }
    
    [self setImages:refreshImages forState:MJRefreshStateRefreshing];
    
    [self setImages:refreshImages forState:MJRefreshStatePulling];
   
}
@end
