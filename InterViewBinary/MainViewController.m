//
//  MainViewController.m
//  TestRuntime
//
//  Created by ZZG on 2021/1/15.
//  Copyright © 2021 coderqi. All rights reserved.
//

#import "MainViewController.h"
#import "Person.h"
#import "Child.h"
#import <objc/runtime.h>
#import "KVOViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"MainViewController----%s",__func__);
    Person * pers = [[Person alloc] init];
    [pers say];
    
    Child * child = [[Child alloc] init];
    [child say];
    [self printClas:[pers class]];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    KVOViewController * kvo = [[KVOViewController alloc] init];
    [self.navigationController pushViewController:kvo animated:YES];
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
