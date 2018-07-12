//
//  Demol1VC.m
//  DemolOne
//
//  Created by 李泽平 on 2018/7/11.
//  Copyright © 2018年 李泽平. All rights reserved.
//

#import "Demol1VC.h"
#import "Demol1Model.h"
#import <ReactiveObjC.h>
#import <malloc/malloc.h>
#import <AVFoundation/AVFoundation.h>

///AVCaptureVideoDataOutputSampleBufferDelegate比较重要的代理方法
@interface Demol1VC ()<UITableViewDelegate, UITableViewDataSource, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *aryData;

@property (nonatomic, strong) Demol1Model *vm;

@end

@implementation Demol1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RAC的KVO在tableView中使用";
    [self.view addSubview:self.tableView];

    __weak typeof(self) WeakSelf = self;
    self.vm = [[Demol1Model alloc] init];
    [self.vm getDataBlock:^(id result, NSString *key) {
        if ([key isEqualToString:@"reloadListData"]) {
            for (ListModel *model in WeakSelf.aryData) {
                if (model.disposable) {
                    [model.disposable dispose];
                }
            }
            [WeakSelf.aryData removeAllObjects];
            WeakSelf.aryData = [[NSMutableArray alloc] initWithArray:result];
            [WeakSelf.tableView reloadData];
        }
    }];
    [self.vm reloadListData];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:@"刷新" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [WeakSelf.vm reloadListData];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
    }
    return _tableView;
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ContactListCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ListModel *model = self.aryData[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.num;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListModel *model = self.aryData[indexPath.row];
    model.num = [NSString stringWithFormat:@"%d", [model.num intValue]+1];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    ListModel *model = self.aryData[indexPath.row];
    if (nil == model.disposable) {
        __weak typeof(self) WeakSelf = self;
        model.disposable =  [RACObserve(model, num) subscribeNext:^(id  _Nullable x) {
            [WeakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
