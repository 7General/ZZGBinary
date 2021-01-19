//
//  KVOViewController.m
//  TestRuntime
//
//  Created by ZZG on 2021/1/15.
//  Copyright © 2021 coderqi. All rights reserved.
//

#import "KVOViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface KVOViewController ()


@property (nonatomic, strong) Person *person;

@property (atomic, strong) NSMutableArray *dataSource;

@property (atomic, strong) NSArray *tempArray;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[Person alloc] init];
    [self.person addObserver:self forKeyPath:@"age" options:(NSKeyValueObservingOptionNew) context:NULL];
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObject:@"0000000"];
    
}


- (void)gos {
    NSLog(@"-----%@",[NSRunLoop currentRunLoop]);
    NSLog(@"==================");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // ******监听KVO
    /**
     1:动态生成子类：NSKVONotifying_xxx,并把isa指向该类
     2:观察setter方法
     3:动态子类重写了很多方法，setNickName（setter） class dealloc _isKVOA
     4:移除观察者的时候isa指向回来
     5：动态子类不会销毁
     */
     self.person.age = @"123";
    // ********查看事件源属于哪一个类型，用bt 查看
    /**
     [self performSelector:@selector(gos) withObject:nil]; source0
     [self performSelector:@selector(gos) withObject:nil afterDelay:2]; 哪怕时间是0也是 source1
     */
    // [self performSelector:@selector(gos) withObject:nil afterDelay:2];
    // ********数组用amtioc修饰问题
    /**
     @property (atomic, strong) NSMutableArray *dataSource;
     atomic:有锁的限制，所有可以保证了多线程下setter、
     
     在一个异步队列的任务中持续地去修改这个属性，在另一个异步队列的任务中持续地去读取这个属性，由于dataArray是由strong来修饰的，那么在dataArray的setter方法中，其实是先保留新值，后释放旧值，再将指针指向新值，所以在后面这个异步队列的任务中，取到的dataArray可能是一个已经被释放的僵尸对象，所以会崩溃。
     */
//    [self arraySafe];
    
    
}

- (void)arraySafe{
    
    
    self.tempArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    dispatch_queue_t queue = dispatch_queue_create(0,DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (NSInteger index = 0; index < 100; index++) {
            self.tempArray = @[[NSString stringWithFormat:@"%ld",index]];
        }
        NSLog(@"1：%@",self.tempArray);
    });
    for (NSInteger index =0; index < 5; index++) {
        dispatch_async(queue, ^{
            NSLog(@"2：%@",self.tempArray);
        });
    }

//    for (NSInteger i = 0; i < 100; i++) {
//        dispatch_async(queue, ^{
//            [self.dataSource addObject:[NSString stringWithFormat:@"%ld",i]];
//        });
//    }
    
//    for (NSInteger i = 0; i < 100; i++) {
//        dispatch_async(queue, ^{
//            [self.dataSource addObject:[NSString stringWithFormat:@"%ld",i]];
//        });
//    }
    
//    for (NSInteger i = 0; i < 100; i++) {
//        dispatch_async(queue, ^{
//            NSLog(@"2--:%ld",[self.dataSource count]);
//        });
//    }
    
    
    
    
    
    
    
    
    //    for (int i = 0; i < 100; i++) {
    //        dispatch_async(queue, ^{
    //            self.dataSource = [[NSMutableArray alloc] init];
    //        });
    //    }
    //
    //    for (NSInteger i = 0; i < 100; i++) {
    //        dispatch_async(queue, ^{
    //            [self.dataSource addObject:[NSString stringWithFormat:@"%ld",i]];
    //        });
    //    }
    //
    //
    //        for (NSInteger i = 0; i < 100; i++) {
    //            dispatch_async(queue, ^{
    //                NSLog(@"2--:%ld",[self.dataSource count]);
    //            });
    //        }
    
    //     dispatch_async(queue, ^{
    //         for (NSInteger index =0; index < 100; index++) {
    //             NSLog(@"1--->%ld",index);
    //         }
    //    });
    //    dispatch_async(queue, ^{
    //         for (NSInteger index =200; index < 300; index++) {
    //             NSLog(@"2--->%ld",index);
    //         }
    //    });
    
    
    //    dispatch_queue_t queue2 = dispatch_queue_create(0,DISPATCH_QUEUE_CONCURRENT);
    //    for (int i = 0; i < 100; i++) {
    //        dispatch_async(queue2, ^{
    //            self.dataSource = [[NSMutableArray alloc] init];
    //        });
    //    }
    //
    //    for (NSInteger i = 0; i < 100; i++) {
    //        dispatch_async(queue2, ^{
    //            [self.dataSource addObject:[NSString stringWithFormat:@"%ld",i]];
    ////            NSLog(@"1--:%ld",[self.dataSource count]);
    //        });
    //    }
    //
    //    for (NSInteger i = 0; i < 100; i++) {
    //        dispatch_async(queue2, ^{
    //            [self.dataSource addObject:[NSString stringWithFormat:@"%ld",i]];
    ////            NSLog(@"2--:%ld",[self.dataSource count]);
    //        });
    //    }
    
    //    for (NSInteger i = 0; i <100; i++) {
    //        dispatch_async(queue, ^{
    ////            [self.dataSource addObject:[NSString stringWithFormat:@"%ld",i]];
    //            NSLog(@"4--:%@",self.dataSource);
    //        });
    //    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"=====%@",change);
}

- (void)dealloc {
    NSLog(@"1111");
    [self printClas:[self.person class]];
    
    NSLog(@"111++++>>>%s",object_getClassName(self.person));
    NSLog(@"1111=====");
    [self.person removeObserver:self forKeyPath:@"age"];
    
    NSLog(@"22");
    [self printClas:NSClassFromString(@"NSKVONotifying_Person")];
    NSLog(@"2222++++>>>%s",object_getClassName(self.person));
    NSLog(@"222=====");
    
    NSLog(@"33");
    [self printClas:[self.person class]];
    NSLog(@"333=====");
    
}


- (void)printClas:(Class)cls {
    int count = objc_getClassList(NULL,0);
    NSMutableArray * array = [NSMutableArray arrayWithObject:cls];
    Class * classes = (Class *)malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    for (NSInteger i = 0; i < count; i++) {
        if (cls == class_getSuperclass(classes[i])) {
            [array addObject:classes[i]];
        }
    }
    free(classes);
    NSLog(@"所有信息---%@",array);
}

@end
