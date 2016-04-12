//
//  ViewController.m
//  likesDemo
//
//  Created by Edwin on 16/4/9.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "ViewController.h"
#import "XWDataManager.h"
#import "XWTableViewCell.h"
#import "XWDataModel.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

static NSString *identifier = @"identifier";
@implementation ViewController

-(NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //数据
    BOOL isLocalExistDatas = [[XWDataManager sharedManager] isLocalExistDatas];
    if (isLocalExistDatas) {
        // 从本地获取
        self.dataArr = [[XWDataManager sharedManager] fetchAllData];
    } else {
        // 这个可以表示从服务器获取
        for (int i = 0; i < 10; i++) {
            XWDataModel *model = [[XWDataModel alloc]init];
             NSInteger likes = arc4random() % 100;
            model.likes = [NSString stringWithFormat:@"%li",(long)likes];
            model.channel = [NSString stringWithFormat:@"频道%i",i+1];
            [self.dataArr addObject:model];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[XWDataManager sharedManager] addDataFromModel:model];
            });
        }
    }
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XWTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
}

#pragma mark - datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    XWDataModel *model = [self.dataArr objectAtIndex:indexPath.row];
    cell.titleLabel.text = model.channel;
    cell.model = model;
    [cell.likesBtn setTitle:model.likes forState:UIControlStateNormal];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
