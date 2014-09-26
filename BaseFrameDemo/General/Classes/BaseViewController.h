//
//  BaseViewController.h
//  BaseFrameDemo
//
//  Created by apple on 14-5-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerMenuButton.h"

#define kTimeOutDefault 20

#if NS_BLOCKS_AVAILABLE
typedef void (^NetworkSuccessBlock)(NSDictionary *dictResponse);
typedef void (^NetworkFailureBlock)(NSError *error);
#endif

@interface BaseViewController : UIViewController

@property(copy) NetworkSuccessBlock successBlock;
@property(copy) NetworkFailureBlock failureBlock;

@property (strong, nonatomic) BannerMenuButton *bannerMenuButton;


- (void)requestDataWithUrl:(NSString *)url successBlock:(NetworkSuccessBlock)success andFailureBlock:(NetworkFailureBlock)failure;
- (void)requestDataWithUrl:(NSString *)url parameters:(NSDictionary *)parameters successBlock:(NetworkSuccessBlock)success andFailureBlock:(NetworkFailureBlock)failure;

@end
