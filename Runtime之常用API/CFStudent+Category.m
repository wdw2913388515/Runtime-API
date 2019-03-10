//
//  CFStudent+Category.m
//  Runtime之常用API
//
//  Created by GongCF on 2018/9/11.
//  Copyright © 2018年 GongCF. All rights reserved.
//

#import "CFStudent+Category.h"

@implementation CFStudent (Category)
/*
 *覆盖Student的方法
 */
- (void)playing
{
    NSLog(@"Student-Category playing！");
}
+ (void)sleeping
{
    NSLog(@"Student-Category sleeping！");
}

/*
 *新添加的方法
 */
- (void)playingBasketball
{
    NSLog(@"Student-Category playing basketball！");
}
+ (void)playingFootball
{
    NSLog(@"Student-Category playing football！");
}
@end
