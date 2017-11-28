//
//  HYNavigationView.m
//  个人中心背景图可拉伸
//
//  Created by 张海勇 on 2017/11/28.
//  Copyright © 2017年 张海勇. All rights reserved.
//

#import "HYNavigationView.h"

@interface HYNavigationView ()
{
    UIButton *leftBtn;
    UIButton *rigthBtn;
    UILabel *titleLab;
}
@end

@implementation HYNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.frame.size.height-40, 40, 40)];
    [self addSubview:leftBtn];
    
    rigthBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-40, self.frame.size.height-40, 40, 40)];
    [self addSubview:rigthBtn];
    
    titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    [self addSubview:titleLab];
}

-(void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    titleLab.textColor = bgColor;
}

-(void)setLeftBtnImageName:(NSString *)leftBtnImageName {
    _leftBtnImageName = leftBtnImageName;
    [leftBtn setImage:[UIImage imageNamed:leftBtnImageName] forState:UIControlStateNormal];
}

-(void)setRightBtnImageName:(NSString *)rightBtnImageName {
    _rightBtnImageName = rightBtnImageName;
    [rigthBtn setImage:[UIImage imageNamed:rightBtnImageName] forState:UIControlStateNormal];
}

-(void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    titleLab.text = titleText;
}

@end
