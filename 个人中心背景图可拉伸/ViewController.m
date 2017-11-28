//
//  ViewController.m
//  个人中心背景图可拉伸
//
//  Created by 张海勇 on 2017/11/28.
//  Copyright © 2017年 张海勇. All rights reserved.
//

//判断是不是iPhoneX
#define isIPhoneX (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 812)
//状态栏高度
#define kStatusBarHeight  (isIPhoneX ? 44 : 20)
//homeBar高度
#define kHomeBarHeight    (isIPhoneX ? 34 : 0)
#define kNavHeight    44
#import "ViewController.h"
#import "HYNavigationView.h"
static const CGFloat ratio = 1.8;


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *bgImageView;
    CGRect originBgImageFrame;
    HYNavigationView *naviBar;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / ratio)];
    bgImageView.image = [UIImage imageNamed:@"bgimage.jpg"];
    [self.view addSubview:bgImageView];
    originBgImageFrame = bgImageView.frame;
    
    naviBar = [[HYNavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kNavHeight+kStatusBarHeight)];
    naviBar.leftBtnImageName = @"tabLiving";
    naviBar.rightBtnImageName = @"tabMine";
    naviBar.titleText = @"个人中心";
    [self.view addSubview:naviBar];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavHeight, self.view.frame.size.width, self.view.frame.size.height-(kStatusBarHeight+kNavHeight+kHomeBarHeight))];
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, bgImageView.frame.size.height-kStatusBarHeight-kNavHeight)];
    view.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = view;
    
    [self.view addSubview:tableView];
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 修改naviBar的透明度
    if (offsetY < (bgImageView.frame.size.height-kStatusBarHeight-kNavHeight)) { //处于naviBar下面
        CGFloat alpha = offsetY / (bgImageView.frame.size.height-kStatusBarHeight-kNavHeight);
        naviBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
        naviBar.leftBtnImageName = @"tabLiving";
        naviBar.rightBtnImageName = @"tabMine";
        naviBar.bgColor = [UIColor whiteColor];
    }else {  //处于naviBar上面
        
        naviBar.leftBtnImageName = @"tabLivingHL";
        naviBar.rightBtnImageName = @"tabMineHL";
        naviBar.bgColor = [UIColor orangeColor];
    }
    
    //将背景图上下移动
    if (offsetY > 0) {  //向上移动
        
        //  高度 ---原来的高度加上偏移量
        //  宽度 ---创建bgImageView的时候，通过宽高比例来计算
        bgImageView.frame = CGRectMake(0, originBgImageFrame.origin.y-offsetY, bgImageView.frame.size.width, bgImageView.frame.size.height);
    }else { //放大
        
        //y  不变
        //x  原来的x - 宽度增加的一半
        bgImageView.frame = CGRectMake(originBgImageFrame.origin.x - (bgImageView.frame.size.width - originBgImageFrame.size.width)/2, 0, originBgImageFrame.size.width - offsetY, (originBgImageFrame.size.width - offsetY)/ratio);
    }
}


#pragma mark UITableViewDelegate&&UITableViewDataSOurcd
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuser = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuser];
    }
    cell.textLabel.text = @"个人中心，图片放大demo";
    return cell;
}



@end
