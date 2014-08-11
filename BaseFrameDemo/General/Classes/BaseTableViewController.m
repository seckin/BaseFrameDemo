//
//  BaseTableViewController.m
//  BaseFrameDemo
//
//  Created by apple on 14-5-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BaseTableViewController.h"

#define kTableViewPullMoreDataThreadholdHeight 44
#define kPROffsetY 30

@interface BaseTableViewController (){

    NSInteger _currentPageNo;
    UIRefreshControl *_refreshControl;
    BOOL _isPullRefresh;///判断是否是下拉
    BOOL scrolling;///是否正在上拉刷新
    
    UIActivityIndicatorView *_activity;
}

@end

@implementation BaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth,50.0f)];
    _refreshControl.tintColor = [UIColor blueColor];
    [_refreshControl addTarget:self action:@selector(requestNewData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = _refreshControl;
    ///添加表格底部的Actitivy;
    _activity= [[UIActivityIndicatorView alloc] initWithFrame : CGRectMake(0, 0, 32.0f, 32.0f)] ;
    [_activity setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray];
    _activity.color=[UIColor blackColor];
    
    [self.tableView addSubview:_activity];
    
    
    _currentPageNo = 1;
    _isPullRefresh = YES;
    
    [self requestData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh Methods

- (void)requestData
{
//    NetworkSuccessBlock successBlock = ^(id data) {
//        [_activitystopAnimating];
//        if (_isPullRefresh) {///如果是下拉。
//            [_questionData removeAllObjects];
//        }
//        [_questionData addObjectsFromArray:data[@"questions"]];
//        [self.tableView reloadData];
//        scrolling = YES;
//        [_refreshControlendRefreshing];
//    };
//    
//    NetworkFailureBlock failureBlock = ^(NSError *error) {
//        scrolling = YES;
//        [_refreshControlendRefreshing];
//    };
//    
//    [SJBQuestionModelrequestQuestionList:_questionTypepageNo:[NSStringstringWithFormat:@"%ld", (long)_currentPageNo] pageSize:@"5"isSolved:_isSolvedonSuccess:successBlock onFailure:failureBlock];
}

- (void)requestNewData
{
    if (_refreshControl.refreshing) {
        scrolling=NO;
        _currentPageNo = 1;
        _isPullRefresh = YES;
        [self requestData];
    }
}

- (void)requestMoreData
{
    _currentPageNo++;
    _isPullRefresh = NO;
    [self requestData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height && scrolling && scrollView.contentOffset.y > 0.0f) {
        _activity.center =CGPointMake(self.tableView.center.x, self.tableView.contentSize.height+kPROffsetY);
        CGSize Size =self.tableView.contentSize;
        Size.height+=kTableViewPullMoreDataThreadholdHeight;
        self.tableView.contentSize=Size;
        
        [_activity startAnimating];
        [self performSelector:@selector(requestMoreData) withObject:nil afterDelay:0.0f];
        scrolling=NO;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
