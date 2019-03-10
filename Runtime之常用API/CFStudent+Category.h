//
//  CFStudent+Category.h
//  Runtime之常用API
//
//  Created by GongCF on 2018/9/11.
//  Copyright © 2018年 GongCF. All rights reserved.
//

/*
 *1.有协议
 *2.有类属性
 *3.有实例属性
 *4.覆盖主类的实例属性
 *5.覆盖主类的实例方法
 *6.覆盖主类的类方法
 *7.添加实例方法
 *8.添加类方法
 */

#import "CFStudent.h"
@protocol ExaminationRul
@optional
- (void)level6test;
@end

/*
 *分类(包含实例方法、类方法、实例属性、类属性、协议列表)
 */
@interface CFStudent (Category)<ExaminationRul>

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *teacher;
@property(class,nonatomic,copy)NSString *partner;
/*
 *覆盖Student的方法
 */
- (void)playing;
+ (void)sleeping;

/*
 *新添加的方法
 */
- (void)playingBasketball;
+ (void)playingFootball;
@end
