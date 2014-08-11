//
//  NRDArrayDataSource.h
//  The Nerdery
//
//  Created by Joshua Sullivan on 11/27/13.
//  Copyright (c) 2013 The Nerdery. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NRDCellConfigurationBlock)(id cell, id dataObject, NSDictionary *userInfo);

@interface NRDArrayDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

@property (readonly, nonatomic) NSArray *dataArray;

/**
 *  Designated initializer.
 *
 *  @param dataArray          The array of objects to be represented in the table.
 *  @param userInfo           An optional dictionary of configuration information.
 *  @param reuseIdentifier    The reuse identifier to use when dequeueing cells. A value of nil will result in the creation of UITableViewCellStyleDefault for tables and an empty UICollectionViewCell for collections.
 *  @param configurationBlock The block which will be used to configure cells. Be sure to properly cast the cell parameter.
 *
 *  @return Returns a configured instance of KDCMArrayDataSource.
 */
- (instancetype)initWithDataArray:(NSArray *)dataArray
                         userInfo:(NSDictionary *)userInfo
                  reuseIdentifier:(NSString *)reuseIdentifier
               configurationBlock:(NRDCellConfigurationBlock)configurationBlock;


@end
