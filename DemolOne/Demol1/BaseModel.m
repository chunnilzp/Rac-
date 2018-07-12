//
//  BaseModel.m
//  DemolOne
//
//  Created by 李泽平 on 2018/7/11.
//  Copyright © 2018年 李泽平. All rights reserved.
//

#import "BaseModel.h"


@implementation BaseModel

- (void)getDataBlock:(RequestCallBackBlock)block{
    self.block = block;
}

@end
