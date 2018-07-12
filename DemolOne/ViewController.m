//
//  ViewController.m
//  DemolOne
//
//  Created by 李泽平 on 2018/7/9.
//  Copyright © 2018年 李泽平. All rights reserved.
//

#import "ViewController.h"
#import "Demol1VC.h"
#import "TwoVC.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *aryData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _aryData = [[NSMutableArray alloc] initWithCapacity:1];
    [_aryData addObject:@"用RAC中的KVO在tableView实现属性监控"];
    [_aryData addObject:@"NSTimer"];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ContactListCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.aryData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[Demol1VC alloc] init] animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:[[TwoVC alloc] init] animated:YES];
            break;
            
        default:
            break;
    }
    
}




@end
