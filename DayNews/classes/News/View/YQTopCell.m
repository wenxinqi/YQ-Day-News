//
//  YQTopCell.m
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQTopCell.h"

@implementation YQTopCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Topcell";
    YQTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YQTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.text = @"123";
    }
    return self;
}

@end
