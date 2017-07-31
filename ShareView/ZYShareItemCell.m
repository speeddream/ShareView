//
//  ZYShareItemCell.m
//  
//
//  Created by ZZY on 16/3/28.
//
//

#import "ZYShareItemCell.h"
#import "ZYShareViewDefine.h"

@interface ZYShareItemCell ()

@property (nonatomic, strong) UIButton *iconView;

@property (nonatomic, strong) UILabel *titleView;

@end

@implementation ZYShareItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addSubview:self.iconView];
    [self addSubview:self.titleView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleInset = 4;
    CGFloat topPadding = 15.f;
    CGFloat cellWidth = self.frame.size.width;
    
    // 图标
    CGFloat iconViewX = ZY_ItemCellPadding / 2;
    CGFloat iconViewY = topPadding;
    CGFloat iconViewW = cellWidth - ZY_ItemCellPadding;
    CGFloat iconViewH = cellWidth - ZY_ItemCellPadding;
    self.iconView.frame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 标题
    CGFloat titleViewX = -titleInset;
    CGFloat titleViewY = topPadding + iconViewH;
    CGFloat titleViewW = cellWidth + 2 * titleInset;
    CGFloat titleViewH = 30.f;
    self.titleView.frame = CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH);
}

#pragma mark - Actions
- (void)iconClick {
    if (self.item.selectionHandler) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZY_HideNotification object:nil];
        self.item.selectionHandler();
    }
}

#pragma mark - setter
- (void)setItem:(ZYShareItem *)item {
    _item = item;

    [self.iconView setImage:[UIImage imageNamed:item.icon] forState:UIControlStateNormal];
    self.titleView.text = item.title;
}

#pragma mark - getter
- (UIButton *)iconView {
    if (!_iconView) {
        _iconView = [[UIButton alloc] init];
        [_iconView addTarget:self
                      action:@selector(iconClick)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconView;
}

- (UILabel *)titleView {
    if (!_titleView) {
        _titleView = [[UILabel alloc] init];
        _titleView.textColor = [UIColor darkGrayColor];
        _titleView.font = [UIFont systemFontOfSize:11];
        _titleView.textAlignment = NSTextAlignmentCenter;
    }
    return _titleView;
}

@end
