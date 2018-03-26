//
//  ViewController.m
//  AnimationDemo
//
//  Created by 李清娟 on 2017/8/17.
//  Copyright © 2017年 --. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * table;
@property (nonatomic,strong)NSMutableArray * arr;
@end

static NSString * kAnimationListId = @"kAnimationListId";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.table];
    self.navigationItem.title = @"CoreAnimationTest";
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:kAnimationListId];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kAnimationListId forIndexPath:indexPath];
    cell.textLabel.text = self.arr[indexPath.row] ;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * className = self.arr[indexPath.row];
    Class class = NSClassFromString(className);
    [self.navigationController pushViewController:[[class alloc]init] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma park getter
-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = 44.0;
        UIView * footV = [UIView new];
        _table.tableFooterView = footV;
    }
    return _table;
}

-(NSMutableArray *)arr{
    if (!_arr) {
        NSArray * a = @[@"Layer1VC",@"Layer2VC",@"Layer3VC",@"AnimationVC"];
        _arr = [NSMutableArray arrayWithArray:a];
    }
    return _arr;
}

@end
