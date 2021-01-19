//
//  Person.h
//  TestRuntime
//
//  Created by ZZG on 2021/1/15.
//  Copyright © 2021 coderqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
- (void)say;

@property (nonatomic, strong) NSString *age;
@end

NS_ASSUME_NONNULL_END
