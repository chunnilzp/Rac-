//
//  TwoVC.m
//  DemolOne
//
//  Created by 李泽平 on 2018/7/9.
//  Copyright © 2018年 李泽平. All rights reserved.
//

#import "TwoVC.h"
#import <ReactiveObjC.h>

@interface TwoVC ()

@property (nonatomic, strong) RACDisposable *disposTime;

@end

@implementation TwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.disposTime = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"date----%@", x);
    }];

}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    if (parent == nil) {
        [self.disposTime dispose];
    }
}

@end
