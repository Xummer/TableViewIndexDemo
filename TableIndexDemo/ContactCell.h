//
//  ContactCell.h
//  TableIndexDemo
//
//  Created by Xummer on 14-4-25.
//  Copyright (c) 2014年 Xummer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactEntity.h"

@interface ContactCell : UITableViewCell

- (void)updateContent:(ContactEntity *)contact;

@end
