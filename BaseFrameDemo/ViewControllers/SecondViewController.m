//
//  SecondViewController.m
//  BaseFrameDemo
//
//  Created by apple on 14-5-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SecondViewController.h"
#import "ArrayDataSource.h"
#import "BaseTableViewCell.h"

#define kTableViewPullMoreDataThreadholdHeight 44
#define kPROffsetY 20

#define kCellIdentifier @"cellIdentifier"


@interface SecondViewController (){
    
    NSInteger _currentPageNo;
    UIRefreshControl *_refreshControl;
    BOOL _isPullRefresh; //判断是否是下拉
    BOOL scrolling; //是否正在上拉刷新
    
    UIActivityIndicatorView *_activity;
    
    
    UIImageView *_lightBlueImgV;
}

@property (strong, nonatomic) ArrayDataSource *dataSource;


@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
     [self requestData];
   // _lightBlueImgV.frame = CGRectMake(10, 100, 300, 300);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _arrayList = [[NSMutableArray alloc] init];
    _refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth,50.0f)];
    _refreshControl.tintColor = [UIColor blueColor];
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在加载..."];
    [_refreshControl addTarget:self action:@selector(requestNewData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = _refreshControl;
    ///添加表格底部的Actitivy;
    _activity= [[UIActivityIndicatorView alloc] initWithFrame : CGRectMake(0, 0, 32.0f, 32.0f)] ;
    _activity.tag = 222;
    [_activity setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray];
    _activity.color=[UIColor blackColor];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, ScreenWidth, 32.0f);
    [footerView addSubview:_activity];
    
    [self.tableView addSubview:_activity];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    _currentPageNo = 1;
    _isPullRefresh = YES;
    
   
    
    
//    UIImage *btnBgImg = [UIImage imageNamed:@"news_cellBG.png"];
//    btnBgImg = [btnBgImg resizableImageWithCapInsets:UIEdgeInsetsMake(98, 0, 37, 0)];
//    _lightBlueImgV = [[UIImageView alloc] init];
//    _lightBlueImgV.image = btnBgImg;
//    
//    
//    [self.view addSubview:_lightBlueImgV];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (void)setupTableViewDataSource
{
    self.dataSource = [[ArrayDataSource alloc] initWithItems:self.arrayList cellIdentifier:kCellIdentifier configureCellBlock:^(BaseTableViewCell *cell, NSObject *object) {
        NSDictionary *dict = (NSDictionary *)object;
        [cell configureForPhoto:nil];
    }];
    self.tableView.dataSource = self.dataSource;
}

#pragma mark - Refresh Methods

- (void)requestData
{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = [NSString stringWithFormat:@"http://prj.morework.cn/wxb/api%@",@"/sys/info"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_activity stopAnimating];
        if (_isPullRefresh) {
            [_arrayList removeAllObjects];
        }
        [_arrayList addObjectsFromArray:responseObject[@"Data"][@"leavetype"]];
        [self.tableView reloadData];
        scrolling = YES;
        [_refreshControl endRefreshing];
        
        [self setupTableViewDataSource];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        scrolling = YES;
        [_refreshControl endRefreshing];
    }];
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
//    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height && scrolling && scrollView.contentOffset.y > 0.0f) {
//        _activity.center =CGPointMake(self.tableView.center.x, self.tableView.contentSize.height+kPROffsetY);
//        CGSize Size =self.tableView.contentSize;
//        Size.height+=kTableViewPullMoreDataThreadholdHeight;
//        self.tableView.contentSize=Size;
//        
//        [_activity startAnimating];
//        [self performSelector:@selector(requestMoreData) withObject:nil afterDelay:0.0f];
//        scrolling=NO;
//    }
    
}

#pragma mark - UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return 5;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return [_arrayList count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
//    NSDictionary *dict = [_arrayList objectAtIndex:indexPath.row];
//    
//    UIView *tempView = [[UIView alloc] init];
//    [cell setBackgroundView:tempView];
//    [cell setBackgroundColor:[UIColor clearColor]];
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = @"name";
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
//    
//    return cell;
//}

#pragma mark - UITableViewDelegate
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row % 2)
//    {
//        [cell setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:1 alpha:1]];
//    }else {
//        [cell setBackgroundColor:[UIColor clearColor]];
//    }
//    cell.textLabel.backgroundColor = [UIColor clearColor];
//    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
//}
@end
