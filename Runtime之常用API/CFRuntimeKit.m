//
//  CFRuntimeKit.m
//  Runtime之常用API
//
//  Created by GongCF on 2018/9/11.
//  Copyright © 2018年 GongCF. All rights reserved.
//

#import "CFRuntimeKit.h"
@implementation CFRuntimeKit
/*
 *1.根据类名获取类
 gdb_objc_realized_classes类表中获取key，与传入类名作比较，返回对应的vlaue
 类表中有一系列MapPair，包含有key，value
 typedef struct _MapPair {
 const void    *key;
 const void    *value;
 } MapPair;

 */
+ (Class)fetchClass:(NSString *)clsName
{
    const char *name = [clsName UTF8String];
    return objc_getClass(name);
}
/*
 *2.根据类获取类名
 class_rw_t结构体中有demangledName，这个就是类名
 */
+ (NSString *)fetchClassName:(Class)cls
{
    const char * name = class_getName(cls);
    
    return [NSString stringWithUTF8String:name];
}
/*
 *3.获取成员变量
 class_ro_t结构体重有ivar_list_t，遍历获取Ivar
 ivar_getName：ivar->name
 ivar_getTypeEncoding：ivar->type
 struct ivar_t {
 const char *name;       //变量名
 const char *type;           //变量类型
 };
 */
+ (NSArray *)fetchIvarList:(Class)cls
{
    unsigned int outCount = 0;
    Ivar *ivarList = class_copyIvarList(cls, &outCount);
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:outCount];
    for (unsigned int i=0 ; i<outCount; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        const char *ivarType = ivar_getTypeEncoding(ivar);
        NSDictionary *ivarDic = @{@"ivarName":[NSString stringWithUTF8String:ivarName],@"ivarType":[NSString stringWithUTF8String:ivarType]};
        [mutableArray addObject:ivarDic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableArray];
}
/*
 *4.获取成员属性
 class_rw_t结构体中有propertys，遍历获取property_t，objc_property_t是property_t的别名
 property_getName：prop->name
 property_getAttributes：prop->attributes
 struct property_t {
 const char *name;       //属性名
 const char *attributes;         //属性内容：strong、weak、编码等
 };
 */
+ (NSArray *)fetchPropertyList:(Class)cls
{
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(cls, &outCount);
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:outCount];
    for (unsigned int i=0 ; i<outCount; i++) {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        const char *propertyType = property_getAttributes(property);
        NSDictionary *propertyDic = @{@"propertyName":[NSString stringWithUTF8String:propertyName],@"propertyType":[NSString stringWithUTF8String:propertyType]};
        [mutableArray addObject:propertyDic];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableArray];
}
/*
 *5.获取类的方法
 遍历class_rw_t中的method_array_t获取Method
 struct method_t {
 SEL name;       //方法名
 const char *types;      //方法类型
 }
 method_getName：method->name
 method_getTypeEncoding：method->types
 */
+ (NSArray *)fetchMethodList:(Class)cls
{
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList(cls, &outCount);
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:outCount];
    for (unsigned int i=0 ; i<outCount; i++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        const char *methodype = method_getTypeEncoding(method);
        NSDictionary *methodDic = @{@"methodName":NSStringFromSelector(methodName),@"methodype":[NSString stringWithUTF8String:methodype]};
        [mutableArray addObject:methodDic];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableArray];
}
/*
 *6.获取协议列表
 遍历class_rw_t中的protocol_array_t获取Protocol
mangledName：protocol_t结构体中有mangledName，Protocol强制转换成了protocol_t
 */
+ (NSArray *)fetchProtocolList:(Class)cls
{
    unsigned int outCount = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(cls, &outCount);
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:outCount];
    for (unsigned int i=0 ; i<outCount; i++) {
        Protocol *protocol = protocolList[i];
        const char * protocolName = protocol_getName(protocol);
        [mutableArray addObject:[NSString stringWithUTF8String:protocolName]];
    }
    free(protocolList);
    return [NSArray arrayWithArray:mutableArray];
}
/*
 *7.动态添加方法
 (1)若添加的方法存在
 添加：不添加，返回旧方法实现
 替换：替换掉旧方法实现，返回旧方法的实现
 (2)若添加的方法不存在
 class_rw_t中methods添加新方法
 分三种情况，总之把新添加的方法放在方法列表的最前面
 
 struct method_t {
 const char *types;      //方法类型
 IMP imp;               //方法地址
 };
 method_getImplementation：m->imp
 method_getTypeEncoding：m->types
 */
+ (void)addMethod:(Class)cls1 methodName:(SEL)method1 methodClass:(Class)cls2 methodIMP:(SEL)method2
{
    Method method = class_getInstanceMethod(cls2, method2);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(cls1, method1, methodIMP, types);
}
/*
 *8.动态交换方法
 IMP m1_imp = m1->imp;
 m1->imp = m2->imp;
 m2->imp = m1_imp;
 */
+ (void)exchangeMethod:(Class)cls firstMethod:(SEL)method1 secondeMethod:(SEL)method2
{
     Method m1 = class_getInstanceMethod(cls, method1);
     Method m2 = class_getInstanceMethod(cls, method2);
    method_exchangeImplementations(m1, m2);
}
@end
