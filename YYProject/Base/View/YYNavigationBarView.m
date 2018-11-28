//
//  YYNavigationBarView.m
//  YYProject
//
//  Created by 于优 on 2018/11/28.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYNavigationBarView.h"

@interface YYNavigationBarView ()

/** 导航栏 */
@property (nonatomic, strong) UIImageView *navView;
/** 导航左按钮（默认是返回图标） */
@property (nonatomic, strong) UIButton *navLeftBtn;
/** 导航右按钮（默认无内容）*/
@property (nonatomic, strong) UIButton *navRightBtn;
/** 导航栏标题 */
@property (nonatomic, strong) UILabel *navTitleLab;
/** 导航栏分割线 */
@property (nonatomic, strong) UIImageView *navSeperateLine;

@end

@implementation YYNavigationBarView

+ (instancetype)shopView {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self crtateNavigationBarView];
    }
    return self;
}

- (void)crtateNavigationBarView {
    
    // 导航栏
    [self addSubview:self.navView];
    // 左按钮
    [self.navView addSubview:self.navLeftBtn];
    // 右按钮
    [self.navView addSubview:self.navRightBtn];
    // 标题
    [self.navView addSubview:self.navTitleLab];
    // 分割线
    [self.navView addSubview:self.navSeperateLine];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self).offset(0);
    }];
    
    [self.navLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView).offset(-1);
        make.left.equalTo(self.navView).offset(0);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [self.navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView).offset(-1);
        make.right.equalTo(self.navView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [self.navTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView).offset(-1);
        make.left.equalTo(self.navView).offset(70);
        make.right.equalTo(self.navView).offset(-70);
        make.height.mas_equalTo(40);
    }];
    
    [self.navSeperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.navView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark - Action

- (void)navLeftBtnClick:(UIButton *)sender {
    if (self.didNavBtnClickHandle) {
        self.didNavBtnClickHandle(YYNavBtnClickTypeLeft, sender);
    }
}

- (void)navRightBtnClick:(UIButton *)sender {
    if (self.didNavBtnClickHandle) {
        self.didNavBtnClickHandle(YYNavBtnClickTypeRight, sender);
    }
}

#pragma mark - setter & getter

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.navView.backgroundColor = backgroundColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    self.navView.image = backgroundImage;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.navTitleLab.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.navTitleLab.textColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.navTitleLab.font = titleFont;
}

- (void)setHiddenLeftBtn:(BOOL)hiddenLeftBtn {
    _hiddenLeftBtn = hiddenLeftBtn;
    self.navLeftBtn.hidden = hiddenLeftBtn;
}
- (void)setLeftBtnTitle:(NSString *)leftBtnTitle {
    _leftBtnTitle = leftBtnTitle;
    [self.navLeftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
}

- (void)setLeftBtnFont:(UIFont *)leftBtnFont {
    _leftBtnFont = leftBtnFont;
    self.navLeftBtn.titleLabel.font = leftBtnFont;
}

- (void)setLeftBtnTitleColor:(UIColor *)leftBtnTitleColor {
    _leftBtnTitleColor = leftBtnTitleColor;
    [self.navLeftBtn setTitleColor:leftBtnTitleColor forState:UIControlStateNormal];
}

- (void)setLeftBtnImage:(UIImage *)leftBtnImage {
    _leftBtnImage  = leftBtnImage;
    [self.navLeftBtn setImage:leftBtnImage forState:UIControlStateNormal];
}

- (void)setRightBtnTitle:(NSString *)rightBtnTitle {
    _rightBtnTitle = rightBtnTitle;
    [self.navRightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
}

- (void)setRightBtnFont:(UIFont *)rightBtnFont {
    _rightBtnFont = rightBtnFont;
    self.navRightBtn.titleLabel.font = rightBtnFont;
}

- (void)setRightBtnTitleColor:(UIColor *)rightBtnTitleColor {
    _rightBtnTitleColor = rightBtnTitleColor;
    [self.navRightBtn setTitleColor:rightBtnTitleColor forState:UIControlStateNormal];
}

- (void)setRightBtnImage:(UIImage *)rightBtnImage {
    _rightBtnImage  = rightBtnImage;
    [self.navRightBtn setImage:rightBtnImage forState:UIControlStateNormal];
}

- (void)setSeperateColor:(UIColor *)seperateColor {
    _seperateColor = seperateColor;
    self.navSeperateLine.backgroundColor = seperateColor;
}

- (void)setSeperateImage:(UIImage *)seperateImage {
    _seperateImage = seperateImage;
    self.navSeperateLine.image = seperateImage;
}

- (UIImageView *)navView {
    if (!_navView) {
        _navView = [[UIImageView alloc] init];
        _navView.backgroundColor = [UIColor whiteColor];
        _navView.userInteractionEnabled = YES;
    }
    return _navView;
}

- (UILabel *)navTitleLab {
    if (!_navTitleLab) {
        _navTitleLab = [[UILabel alloc] init];
        _navTitleLab.textAlignment = NSTextAlignmentCenter;
        _navTitleLab.font = [UIFont systemFontOfSize:18];
        _navTitleLab.textColor = kFontColor;
    }
    return _navTitleLab;
}

- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        _navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navLeftBtn addTarget:self action:@selector(navLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navLeftBtn setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
    }
    return _navLeftBtn;
}

- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        _navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navRightBtn addTarget:self action:@selector(navRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _navRightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_navRightBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    }
    return _navRightBtn;
}

- (UIImageView *)navSeperateLine {
    if (!_navSeperateLine) {
        _navSeperateLine = [[UIImageView alloc] init];
        _navSeperateLine.backgroundColor = [UIColor clearColor];
    }
    return _navSeperateLine;
}


@end
