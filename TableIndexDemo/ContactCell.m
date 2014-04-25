//
//  ContactCell.m
//  TableIndexDemo
//
//  Created by Xummer on 14-4-25.
//  Copyright (c) 2014年 Xummer. All rights reserved.
//

#import "ContactCell.h"
@interface ContactCell ()

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *subLabel;

@end

@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self _init];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self _init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _avatarImageView.frame = (CGRect){
        .origin.x = 0,
        .origin.y = 0,
        .size.width = CGRectGetHeight(self.bounds),
        .size.height = CGRectGetHeight(self.bounds)
    };
    
    _nameLabel.frame = (CGRect){
        .origin.x = CGRectGetMaxX(_avatarImageView.frame),
        .origin.y = 0,
        .size.width = CGRectGetWidth(self.bounds) - CGRectGetMaxX(_avatarImageView.frame),
        .size.height = CGRectGetHeight(self.bounds) * .5f
    };
    
    _subLabel.frame = (CGRect){
        .origin.x = CGRectGetMinX(_nameLabel.frame),
        .origin.y = CGRectGetMaxY(_nameLabel.frame),
        .size.width = CGRectGetWidth(_nameLabel.frame),
        .size.height = CGRectGetHeight(self.bounds) - CGRectGetHeight(_nameLabel.frame)
    };
    
}

#pragma mark - Public Method

- (void)updateContent:(ContactEntity *)contact {
//    _avatarImageView.backgroundColor = [UIColor colorWithWhite:(arc4random() % 255)/255.0f alpha:1];
    _avatarImageView.image = [UIImage imageNamed:contact.avatarUrl];
    _nameLabel.text = contact.name;
    _subLabel.text = contact.detail;
}

#pragma mark - Private Method
- (void)_init {
    
    self.avatarImageView = [[UIImageView alloc] init];
    [self addSubview:_avatarImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor darkGrayColor];
    _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:_nameLabel];
    
    self.subLabel = [[UILabel alloc] init];
    _subLabel.textAlignment = NSTextAlignmentLeft;
    _subLabel.textColor = [UIColor lightGrayColor];
    _subLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_subLabel];
    
}

@end
