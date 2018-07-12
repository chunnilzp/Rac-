//
//  Demol1Model.m
//  DemolOne
//
//  Created by 李泽平 on 2018/7/11.
//  Copyright © 2018年 李泽平. All rights reserved.
//

#import "Demol1Model.h"

@implementation ListModel

- (void)dealloc{
    if (self.disposable) {
        [self.disposable dispose];
    }
}

@end

@implementation Demol1Model

- (void)reloadListData{
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 25; i++) {
        ListModel *model = [[ListModel alloc] init];
        model.name = [self randomStringWithLength:2];
        model.num = [NSString stringWithFormat:@"%d", i];
        [ary addObject:model];
    }
    self.block(ary, NSStringFromSelector(@selector(reloadListData)));
}


-(NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"赵钱孙李张三李四王二麻子马云马化腾雷军潘石屹王健林王建国王思聪沈腾";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return randomString;
}



@end
