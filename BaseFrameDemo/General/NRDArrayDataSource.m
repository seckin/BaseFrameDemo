//
//  NRDArrayDataSource.m
//  The Nerdery
//
//  Created by Joshua Sullivan on 11/27/13.
//  Copyright (c) 2013 The Nerdery. All rights reserved.
//

#import "NRDArrayDataSource.h"

static NSString *const kDefaultCellReuseIdentifier = @"cellIdentifier";

@interface NRDArrayDataSource ()

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSDictionary *userInfo;
@property (strong, nonatomic) NSString *reuseIdentifier;
@property (copy) NRDCellConfigurationBlock configurationBlock;

@property (assign, nonatomic) BOOL collectionViewCellRegistered;

@end

@implementation NRDArrayDataSource

- (instancetype)initWithDataArray:(NSArray *)dataArray
                         userInfo:(NSDictionary *)userInfo
                  reuseIdentifier:(NSString *)reuseIdentifier
               configurationBlock:(NRDCellConfigurationBlock)configurationBlock
{
    self = [super init];
    if (self) {
        self.dataArray = dataArray;
        self.userInfo = userInfo;
        self.reuseIdentifier = reuseIdentifier;
        self.configurationBlock = configurationBlock;
        self.collectionViewCellRegistered = NO;
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    // If we have a user-specified reuse identifier, use it to create the cell, otherwise create a generic one.
    if (self.reuseIdentifier) {
        cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:kDefaultCellReuseIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDefaultCellReuseIdentifier];
        }
    }
    
    // Invoke the configuration block on the cell with the appropriate data.
    self.configurationBlock(cell, self.dataArray[indexPath.row], self.userInfo);
    return cell;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // Register a generic cell in case the user forgets to specify one.
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kDefaultCellReuseIdentifier];
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    // If we have a user-specified reuse identifier, use it to create the cell, otherwise create a generic one.
    if (self.reuseIdentifier) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier forIndexPath:indexPath];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDefaultCellReuseIdentifier forIndexPath:indexPath];
    }
    
    // Invoke the configuration block on the cell with the appropriate data.
    self.configurationBlock(cell, self.dataArray[indexPath.row], self.userInfo);
    return cell;
}

@end
