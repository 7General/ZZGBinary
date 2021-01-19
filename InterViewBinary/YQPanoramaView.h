//
//  YQPanoramaView.h
//  TestRuntime
//
//  Created by ZZG on 2020/12/16.
//  Copyright © 2020 coderqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQPanoramaView : UIView

@property(nonatomic,strong)UIImage *image;

//鱼眼效果，默认开启
@property(nonatomic,assign)BOOL Fisheye;

//惯性滑动，追求滑动稳定可以关闭。
@property(nonatomic,assign)BOOL scrollInertia;

@end

NS_ASSUME_NONNULL_END
