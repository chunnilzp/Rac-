//
//  Demol1Model.h
//  DemolOne
//
//  Created by 李泽平 on 2018/7/11.
//  Copyright © 2018年 李泽平. All rights reserved.
//

#import "BaseModel.h"
#import <ReactiveObjC.h>

@interface ListModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSString *num;

@property (nonatomic, strong) RACDisposable *disposable;

@end

@interface Demol1Model : BaseModel

- (void)reloadListData;

@end
