//
//  SecondViewController.h
//  BaseFrameDemo
//
//  Created by apple on 14-5-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewCell+ConfigureForMoel.h"

@interface SecondViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *arrayList;

@end
