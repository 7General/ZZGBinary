//
//  ViewController.m
//  TestRuntime
//
//  Created by Arthur on 2020/4/21.
//  Copyright © 2020 coderqi. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "YQPanoramaView.h"
#import "StudentCls.h"
#import "childSStudent.h"
//#import "StudentCls+h1.h"


#import "HOOKFuncation.h"
@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) YQPanoramaView *panaromview;

@property (nonatomic, strong) NSPort *port;
@property (nonatomic, assign) BOOL shuldStopRun;
@property (nonatomic, strong) NSThread *thread;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.port = [NSMachPort port];
    self.shuldStopRun = NO;
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadTest) object:nil];
    [self.thread start];
//    //方法交换测试
//    [self doExchange];
//    [ViewController doPrint1];
//
//
//    //方法调用测试
//    [self doSendMessageToAnimal];
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:6];
//    self.index = 0;
    
//    NSRunLoop * runloop = [NSRunLoop currentRunLoop];
//    @autoreleasepool {
//        NSRunLoop * runloop2 = [NSRunLoop currentRunLoop];
//        @autoreleasepool {
//            NSRunLoop * runloop3 = [NSRunLoop currentRunLoop];
//            NSLog(@"===");
//        }
//    }
//    NSString * str1 = [NSMutableString stringWithString:@"123"];
//    NSString * str2 = [NSMutableString stringWithString:@"123"];
//    NSMutableSet * set = [NSMutableSet set];
//    [set addObject:str2];
//    [set addObject:str1];
//    NSLog(@"---%@",set);
//    if ([str1 isEqual:str2]) {
//        NSLog(@"+++++++++++++");
//    }
//
//    UIColor * color = [UIColor colorWithRed:50/100 green:50/100 blue:50/100 alpha:1];
//    UIColor * color2 = [UIColor colorWithRed:50/100 green:50/100 blue:50/100 alpha:1];
//    if ([color isEqual:color2]) {
//        NSLog(@"===========");
//    }
//    [set addObject:color2];
//    [set addObject:color];
//    NSLog(@"---%@",set);
//
////    NSString * str1 = @"123";
////    NSString * str2 = @"123";
////    if ([str2 isEqualToString:str2]) {
////        NSLog(@"----");
////    }
//
//    //初始化
//    self.panaromview = [[YQPanoramaView alloc]initWithFrame:CGRectMake(20,20,
//                                                                       self.view.frame.size.width-40,
//                                                                         self.view.frame.size.height-80)];
//
//    //设图片
//    self.panaromview.image = [UIImage imageNamed:@"123.jpg"];
//
//    //显示
//    [self.view addSubview:self.panaromview];
    
//    Class cls = [StudentCls superclass];
//    NSLog(@"----%@",NSStringFromClass(cls));
    StudentCls * student = [[StudentCls alloc] init];
    [student categoryTest];
//    childSStudent * child = [[childSStudent alloc] init];
//    NSLog(@"1----%@",child);
//    NSLog(@"2----%p",child);
//    NSLog(@"3----%p",&child);
    
//    NSArray * array1 = @[@"1",@"2",@"3",@"4",@"5"];
//    NSArray * array2 = [array1 copy];
//    NSLog(@"---%@",array2);
    
}

- (void)action {
    NSLog(@"---%s",__func__);
}

- (void)test {
    dispatch_queue_t queue = dispatch_queue_create("123", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"1");
        [self performSelector:@selector(action) withObject:nil afterDelay:2.0];
        NSLog(@"3");
    });
}
- (void)test1 {
    NSThread * thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
    }];
    [thread start];
    // 没有runloop
    [self performSelector:@selector(action) onThread:thread withObject:nil waitUntilDone:NO];
}

- (void)test2 {
    dispatch_queue_t queue = dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%d",i);
        });
    }
    dispatch_barrier_async(queue, ^{
        NSLog(@"102");
    });
    dispatch_async(queue, ^{
        NSLog(@"103");
    });
}

- (void)test3 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%d",i);
        });
    }
    dispatch_barrier_async(queue, ^{
        NSLog(@"102");
    });
    dispatch_async(queue, ^{
        NSLog(@"103");
    });
}

- (void)threadTest {
    NSLog(@"%s",__func__);
    @autoreleasepool {
        NSRunLoop * runloop = [NSRunLoop currentRunLoop];
        //发消息
        [runloop addPort:self.port forMode:NSDefaultRunLoopMode];
//        [self performSelector:@selector(removeSourceTimer) withObject:nil afterDelay:2];
//        while (!self.shuldStopRun) {
//            [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//        }
        while (!self.shuldStopRun && [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
        NSLog(@"====exit");
        
    }
}
- (void)removeSourceTimer {
    self.shuldStopRun = YES;
//    [[NSRunLoop currentRunLoop] removePort:self.port forMode:NSDefaultRunLoopMode];
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s",__func__);
}
- (void)test4 {

    [self performSelector:@selector(removeSourceTimer) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)releseArray {
    dispatch_queue_t queue = dispatch_queue_create(0, 0);
    for (NSInteger i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
//            self.dataSource = [NSMutableArray array];
            [self.dataSource addObject:@"44444"];
        });
        
        dispatch_async(queue, ^{
        //            self.dataSource = [NSMutableArray array];
                    [self.dataSource removeObjectAtIndex:0];
                });
        NSLog(@"%ld",i);
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self test];
//    [self test4];
    [self releseArray];
//    HOOKFuncation * hook = [[HOOKFuncation alloc] init];
//    [hook hookFuncation];
    
//    self.index++;
//    [self.dataSource addObject:[NSString stringWithFormat:@"%ld",self.index]];
//    NSLog(@"--->>>:%@",self.dataSource);
    
    
//    dispatch_queue_t queue = dispatch_queue_create(@"syn", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        NSLog(@"2");
//        dispatch_sync(queue, ^{
//            NSLog(@"33");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"5");
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_async(queue, ^{
//        NSLog(@"1");
//    [self performSelector:@selector(go) withObject:nil afterDelay:0];
//        NSLog(@"3");
//    });
    
//    [self gcdQueue];
    
}

- (void)gcdQueue {
    // D---->A,B
    dispatch_group_t g1 = dispatch_group_create();
    // E---->B,C
    dispatch_group_t g2 = dispatch_group_create();
    // F---->D,E
    dispatch_group_t g3 = dispatch_group_create();
    
    dispatch_group_enter(g1);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"A-----------");
        }
        dispatch_group_leave(g1);
    });
    
    dispatch_group_enter(g1);
    dispatch_group_enter(g2);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"B-----------");
        }
        dispatch_group_leave(g1);
        dispatch_group_leave(g2);
    });
    
    dispatch_group_enter(g2);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"C-----------");
        }
        dispatch_group_leave(g2);
    });
    
    dispatch_group_enter(g3);
    dispatch_group_notify(g1, dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"D-----------");
        }
        dispatch_group_leave(g3);
    });
    
    dispatch_group_enter(g3);
       dispatch_group_notify(g2, dispatch_get_global_queue(0, 0), ^{
           for (NSInteger i = 0; i < 3; i++) {
               NSLog(@"E-----------");
           }
           dispatch_group_leave(g3);
       });
    
//    dispatch_group_enter(g3);
    dispatch_group_notify(g3, dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"F-----------");
        }
//        dispatch_group_leave(g3);
    });
    
}

- (void)go {
    NSLog(@"2");
}

#pragma mark -------------------交换方法实现------------------------------
-(void)doExchange{
    Method originalMethod = class_getInstanceMethod([self class], @selector(doPrint1));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(doPrint2));
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
//    Class class2 = object_getClass([self class]);
//    class_swizzleInstanceMethod(class2, @selector(doPrint1), @selector(doPrint2));
}

+(void)doPrint1{
    NSLog(@"print-----------");
}

+(void)doPrint2{
    NSLog(@"print+++++++++++");
}

#pragma mark --------------------向对象发送消息---------------------------
- (void) doSendMessageToAnimal{
    
    
}

-(id)performObject:(NSObject *)obj Selector:(SEL)aSelector withObject:(NSArray *)object
{
    
    #pragma mark 通过Invocation进行调用，这其中的参数不会进行强引用，如果在调用之前参数被释放了，就会产生野指针异常。
    //获得方法签名
    NSMethodSignature *signature = [[obj class] instanceMethodSignatureForSelector:aSelector];
    if (signature == nil) {
        return nil;
    }
    //使用NSInvocation进行参数的封装
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = obj;
    invocation.selector = aSelector;
    
    //减去 self _cmd
    NSInteger paramtersCount = signature.numberOfArguments - 2;
    paramtersCount = MIN(object.count, paramtersCount);
    
    for (int i = 0; i < paramtersCount; i++) {
        id obj = object[i];
        
        if ([obj isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&obj atIndex:i+2];
        
    }
    
    [invocation invoke];
    
    id returnValue = nil;
    if (signature.methodReturnLength > 0) { //如果有返回值的话，才需要去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
    
}



@end
