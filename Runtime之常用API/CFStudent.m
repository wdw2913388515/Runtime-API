//
//  CFStudent.m
//  5NSObject常用方法解析
//
//  Created by GongCF on 2018/9/9.
//  Copyright © 2018年 GongCF. All rights reserved.
//

#import "CFStudent.h"

@interface CFStudent()
{
    NSInteger _num;     //学号
    NSNumber *_class;   //班级
}
@property(nonatomic,copy)NSString *age;     //年龄
@property(nonatomic,copy)NSArray *score;   //分数
@end
@implementation CFStudent
@synthesize bookNum;
- (void)eatingWithFood:(NSString *)foodName inPlace:(NSString*)placeName
{
    NSLog(@"Student eatingWithFood:%@ inPlace:%@!",foodName,placeName);
}
- (void)playing
{
    NSLog(@"Student playing！");
}
+ (void)sleeping
{
    NSLog(@"Student sleeping！");
}

/*
 *私有实例方法
 */
- (BOOL)reading
{
    NSLog(@"Student reading！");
    return YES;
}
- (void)writing
{
    NSLog(@"Student writing！");
}

/*
 *私有类方法
 */
+ (void)studying
{
    NSLog(@"Student studying！");
}

/*
 *协议方法
 */
- (void)borrowBook
{
    NSLog(@"borrowBook!");
}
+ (void)lendBook
{
    NSLog(@"lendBook!");
}

@end
