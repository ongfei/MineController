//
//  MineController.m
//  SinoMT
//
//  Created by df on 16/6/13.
//  Copyright © 2016年 Dyf. All rights reserved.
//

#import "MineController.h"
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)

@interface MineController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UINavigationBar * navigationView;
@property (nonatomic, strong) UILabel * NavigationTitle;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UIImageView *headImageV;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];

    [self prepareLayoutNavigation];
    [self prepareLayoutSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    ;
    self.navigationView.hidden = self.NavigationTitle.hidden = NO;

}

- (void)viewWillDisappear:(BOOL)animated {
    self.NavigationTitle.hidden = self.navigationView.hidden = YES;

}

- (void)prepareLayoutNavigation {

    self.navigationView = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, 64)];
    self.navigationView.backgroundColor = [UIColor colorWithRed:0.1704 green:1.0 blue:0.8963 alpha:1.0];
    
    self.NavigationTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    self.NavigationTitle.backgroundColor = [UIColor clearColor];
    self.NavigationTitle.textColor = [UIColor blackColor];
    self.NavigationTitle.text = @"我的";
    self.NavigationTitle.textAlignment = 1;
    self.NavigationTitle.font = [UIFont boldSystemFontOfSize:17];
    self.NavigationTitle.alpha = 1.0f;

    [self.navigationView addSubview:self.NavigationTitle];
    [self.navigationController.navigationBar addSubview:self.navigationView];
}

- (void)prepareLayoutSubViews {
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, ScreenWidth, ScreenHeight + 64) style:(UITableViewStylePlain)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    self.headImageV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    headView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cloud@3x" ofType:@"png"]];
    self.headImageV = headView;
    headView.contentMode = UIViewContentModeScaleAspectFill;
//    headView.backgroundColor = [UIColor greenColor];
    [self.tableV addSubview: headView];
    [self.view addSubview:self.tableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y + 64)/200.0f;
    NSLog(@"%f, %f",offset_Y,alpha);
    self.navigationView.alpha = alpha;
    if (offset_Y + 64 < 0) {
        CGRect frame = _headImageV.frame;
        frame.origin.y = offset_Y + 64;
        frame.size.height = -offset_Y - 64 + 200;
        _headImageV.frame = frame;
    }
}

@end
