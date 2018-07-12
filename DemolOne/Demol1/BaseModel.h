//
//  BaseModel.h
//  DemolOne
//
//  Created by 李泽平 on 2018/7/11.
//  Copyright © 2018年 李泽平. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestCallBackBlock)(id result, NSString *key);

@interface BaseModel : NSObject

@property (nonatomic, strong) RequestCallBackBlock block;

- (void)getDataBlock:(RequestCallBackBlock)block;

@end
