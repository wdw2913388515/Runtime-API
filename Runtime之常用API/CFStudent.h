//
//  CFStudent.h
//  5NSObject常用方法解析
//
//  Created by GongCF on 2018/9/9.
//  Copyright © 2018年 GongCF. All rights reserved.
//

/*
 *1.有协议方法
 *2.有协议属性
 *3.有共有属性
 *4.有私有变量
 *4.有共有实例方法
 *5.有共有类方法
 *6.有私有实例方法
 *7.有私有类方法
 */

#import <Foundation/Foundation.h>
/*
 *协议(包含实例方法、类方、实例属性)
 */
@protocol BorrowRule    //借进来
@property(nonatomic,assign)NSInteger bookNum;
@optional
- (void)borrowBook;
@end
@protocol LendRule      //借出去
@optional
+ (void)lendBook;
@end

@interface CFStudent : NSObject<BorrowRule,LendRule>
/*
 *共有属性
 */
@property(nonatomic,copy)NSString *name;    //名字
@property(nonatomic,assign)BOOL sex;        //性别

/*
 *公有实例方法
 */
- (void)playing;
- (void)eatingWithFood:(NSString *)foodName inPlace:(NSString*)placeName;
/*
 *类方法
 */
+ (void)sleeping;

@end
