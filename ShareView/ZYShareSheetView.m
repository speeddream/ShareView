//
//  ZYShareSheetView.m
//  
//
//  Created by ZZY on 16/3/28.
//
//

#import "ZYShareSheetView.h"
#import "ZYShareViewDefine.h"
#import "ZYShareSheetCell.h"

#define ZY_TitleHeight  30.f
#define ZY_TitlePadding 20.f

@interface ZYShareSheetView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZYShareSheetView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addSubview:self.titleLabel];
    [self addSubview:self.tableView];
    [self addSubview:self.cancelButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    frame.size.height = [self shareSheetHeight];
    self.frame = frame;
    
    // 标题
    self.titleLabel.frame = CGRectMake(ZY_TitlePadding, 0, ZY_ScreenWidth - 2 * ZY_TitlePadding, self.titleHeight);
    
    // 取消按钮
    self.cancelButton.frame = CGRectMake(0, self.frame.size.height - ZY_CancelButtonHeight, ZY_ScreenWidth, ZY_CancelButtonHeight);
    
    // TableView
    self.tableView.frame = CGRectMake(0, self.titleHeight, ZY_ScreenWidth, self.datas.count * ZY_ItemCellHeight);
}

#pragma mark - Action
- (void)cancelButtonClick {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = self.datas[indexPath.row];
    ZYShareSheetCell *cell = [ZYShareSheetCell cellWithTableView:tableView];
    cell.items = items;
    
    return cell;
}

#pragma mark - setter

//- (void)setShareArray:(NSArray *)shareArray
//{
//    _shareArray = shareArray;
//    
//    if (shareArray.count) {
//        [self.dataArray insertObject:shareArray atIndex:0];
//    }
//}
//
//- (void)setFunctionArray:(NSArray *)functionArray
//{
//    _functionArray = functionArray;
//    
//    if (functionArray) {
//        [self.dataArray addObject:functionArray];
//    }
//}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.text = @"分享到";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = ZY_ItemCellHeight;
        _tableView.bounces = NO;
        _tableView.backgroundColor = nil;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]  forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.9 alpha:1.0]] forState:UIControlStateHighlighted];
        [_cancelButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (CGFloat)shareSheetHeight {
    return self.initialHeight + self.datas.count * ZY_ItemCellHeight - 1; // 这个-1用来让取消button挡住下面cell的seperator
}

- (CGFloat)initialHeight {
    return ZY_CancelButtonHeight + self.titleHeight;
}

- (CGFloat)titleHeight {
    return self.titleLabel.text.length? ZY_TitleHeight : 0;
}

@end
