# Runtime-API
根据类名获取类、根据类获取类名、获取成员变量、获取成员属性、获取类的方法、获取协议列表、动态添加变量、动态添加方法、动态交换方法

**1.根据类名获取类**
> + (Class)fetchClass:(NSString *)clsName;

**2.根据类获取类名**
>+ (NSString *)fetchClassName:(Class)cls;

**3.获取成员变量**
>+ (NSArray *)fetchIvarList:(Class)cls;

**4.获取成员属性**
>+ (NSArray *)fetchPropertyList:(Class)cls;

**5.获取类的方法**
>+ (NSArray *)fetchMethodList:(Class)cls;

**6.获取协议列表**
>+ (NSArray *)fetchProtocolList:(Class)cls;

**7.动态添加方法**
>+ (void)addMethod:(Class)cls1 methodName:(SEL)method1 methodClass:(Class)cls2 methodIMP:(SEL)method2;

**8.动态交换方法**
>+ (void)exchangeMethod:(Class)cls firstMethod:(SEL)method1 secondeMethod:(SEL)method2;
