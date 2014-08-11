//
//  BaseTableViewCell+ConfigureForMoel.m
//  BaseFrameDemo
//
//  Created by apple on 14-8-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BaseTableViewCell+ConfigureForMoel.h"

@implementation BaseTableViewCell (ConfigureForMoel)


- (void)configureForPhoto:(BaseModel *)model
{
//    self.photoTitleLabel.text = photo.name;
//    NSString* date = [self.dateFormatter stringFromDate:photo.creationDate];
//    self.photoDateLabel.text = date;
    
    self.textLabel.text = @"name";
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
