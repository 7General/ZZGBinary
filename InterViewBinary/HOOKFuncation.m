//
//  HOOKFuncation.m
//  TestRuntime
//
//  Created by ZZG on 2020/4/28.
//  Copyright © 2020 coderqi. All rights reserved.
//

#import "HOOKFuncation.h"
#import "NSObject+MLFinder.h"

//@interface Animal : NSObject
//- (void)JRquestionWithFood:(NSString *)food andWater:(NSString *)water andKnowledge:(NSInteger)knowledge;
//@end
//
//@interface Animal(helper)
//
//@end
//@implementation Animal(helper)
//
//+(void)load {
//    [self swizzleSEL:@selector(questionWithFood:andWater:andKnowledge:) withSEL:@selector(JRquestionWithFood:andWater:andKnowledge:)];
//}
//- (void)JRquestionWithFood:(NSString *)food andWater:(NSString *)water andKnowledge:(NSInteger)knowledge {
//    [self JRquestionWithFood:food andWater:water andKnowledge:knowledge];
//    NSLog(@"---===-===");
//}
//
//@end



@implementation HOOKFuncation

- (void)hookFuncation {
//    Animal *an = [[Animal alloc] init];
//    [an JRquestionWithFood:@"foor" andWater:@"water" andKnowledge:12];
}
@end
