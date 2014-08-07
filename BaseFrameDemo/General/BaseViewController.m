//
//  BaseViewController.m
//  BaseFrameDemo
//
//  Created by apple on 14-5-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout= UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
}

- (void)getDataWithURL:(NSString *)UrlStr parameters:(NSDictionary *)parameters
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (parameters) {
        [manager GET:UrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }else{
        [manager POST:UrlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }

    
}

- (void)requestDataWithUrl:(NSString *)url successBlock:(NetworkSuccessBlock)success andFailureBlock:(NetworkFailureBlock)failure
{
//    if (self.maskView.superview != self.view) {
//        [self.view addSubview:self.maskView];
//    }
//    [self.view bringSubviewToFront:self.maskView];
//    [self.indicatorView startAnimating];
//    
//    self.bActionRequst = NO;
    
    self.successBlock = success;
    self.failureBlock = failure;
    [self getDataWithURL:url parameters:nil];
}

- (void)requestDataWithUrl:(NSString *)url parameters:(NSDictionary *)parameters successBlock:(NetworkSuccessBlock)success andFailureBlock:(NetworkFailureBlock)failure{

    self.successBlock = success;
    self.failureBlock = failure;
    [self getDataWithURL:url parameters:parameters];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
