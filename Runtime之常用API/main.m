//
//  main.m
//  Runtime之常用API
//
//  Created by GongCF on 2018/9/11.
//  Copyright © 2018年 GongCF. All rights reserved.
//

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#import <Foundation/Foundation.h>
#import "CFRuntimeKit.h"
#import "CFStudent+Category.h"
#import "CFTest.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       /*
        *1.根据类名获取类
        */
        Class cls = [CFRuntimeKit fetchClass:@"CFStudent"];
        NSLog(@"cls：%@",cls);
        
        /*
         *2.根据类获取类名
         */
        NSString *name = [CFRuntimeKit fetchClassName:cls];
        NSLog(@"name：%@",name);
        
        /*
         *3.获取成员变量
         不包含分类中的属性，因为分类中的属性是没有自动生成setter、getter方法的，即没有对应的变量
         */
        NSArray *ivarArr = [CFRuntimeKit fetchIvarList:cls];
        NSLog(@"ivarArr：%@",ivarArr);
        
        /*
         *4.获取成员属性
         */
        NSArray *propertyArr = [CFRuntimeKit fetchPropertyList:cls];
        NSLog(@"propertyArr：%@",propertyArr);
        
        /*
         *5.获取类的方法
         */
        //实例方法列表
        NSArray *instanceMethodArr = [CFRuntimeKit fetchMethodList:cls];
        NSLog(@"instanceMethodArr：%@",instanceMethodArr);
        //类方法列表
        NSArray *classMethodArr = [CFRuntimeKit fetchMethodList:objc_getMetaClass("CFStudent")];
        NSLog(@"classMethodArr：%@",classMethodArr);
        
        /*
         *6.获取协议列表
         */
        NSArray *protocolArr = [CFRuntimeKit fetchProtocolList:cls];
        NSLog(@"protocolArr：%@",protocolArr);
        
        /*
         *7.动态添加变量
         (1)只能在objc_allocateClassPair之后，objc_registerClassPair之前使用
         为什么？因为编译好的类，instanceSize大小是确定好的
         (2)被添加对象不能是元类
         (3)class_addIvar：class_ro_t中的ivar_list_t列表添加ivar
         (4)objc_allocateClassPair：创建类；并给类设置基本信息；关联父类、元类
         (5)objc_registerClassPair：把类名和类对象添加到gdb_objc_realized_classes表中去
         */
        
        //创建新类，并开辟空间
        Class Person = objc_allocateClassPair([NSObject class], "Person", 0);

        //这个Bool是用来判断是否添加成功的
       BOOL isAdded1 = class_addIvar(Person, "name", sizeof(NSString*), log2( sizeof(NSString*)), @encode(NSString*));
        //注册类
        objc_registerClassPair(Person);
        
        // ---------------------------------------------------
        //这是没有编译过的类【Person】
        if (isAdded1) {
            id person = [[Person alloc]init];
            [person setValue:@"lilei" forKey:@"name"];
            NSLog(@"name：%@",[person valueForKey:@"name"]);
        }
        //这个Bool是用来判断是否添加成功的
        BOOL isAdded2 = class_addIvar([CFStudent class], "address", sizeof(NSString*), log2( sizeof(NSString*)), @encode(NSString*));
        //这是已经编译过的类【CFStudent】
        if (isAdded2) {
            id student = [[CFStudent alloc]init];
            [student setValue:@"beijing" forKey:@"address"];
            NSLog(@"address：%@",[student valueForKey:@"address"]);
        }
        // ---------------------------------------------------
        
        
        /*
         *8.动态添加方法
         */
        //(1)添加不存在的实例方法
        CFStudent *student = [[CFStudent alloc]init];
        [CFRuntimeKit addMethod:cls methodName:@selector(dynamicMethod) methodClass:[CFTest class] methodIMP:@selector(dynamicMethod)];
        [student performSelector:@selector(dynamicMethod)];
        //(2)添加存在的实例方法
        [CFRuntimeKit addMethod:cls methodName:@selector(eatingWithFood:inPlace:) methodClass:[CFTest class] methodIMP:@selector(dynamicMethod)];
        [student performSelector:@selector(eatingWithFood:inPlace:) withObject:@"apple" withObject:@"kitchen"];
        /*
         *9.动态交换方法
         这里Category中的palying覆盖掉了主类中的playing
         因为分类的方法在方法列表最前面，class_getInstanceMethod从方法列表头开始搜索的
         */
        [CFRuntimeKit exchangeMethod:cls firstMethod:@selector(playing) secondeMethod:@selector(eatingWithFood:inPlace:)];
        [student performSelector:@selector(playing) withObject:@"apple" withObject:@"kitchen"];
        [student performSelector:@selector(eatingWithFood:inPlace:)];
    }
    return 0;
}


