//
//  UITableView+MJRefresh.h
//  toBook
//
//  Created by Mac on 16/12/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh/MJRefresh.h"

@interface UITableView (MJRefresh)

//添加顶部刷新
-(void)headerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block ;

//手动顶部刷新
-(void)headerBeginRefresh;

//取消顶部刷新状态
-(void)headerEndRefresh;

//添加底部刷新
-(void)footerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block;

//手动底部刷新
-(void)footerBeginRefresh;

//取消底部刷新状态
-(void)footerEndRefresh;

//取消底部刷新状态并显示无数据
-(void)footerEndRefreshNoMoreData;

//重置无数据状态
-(void)footerResetNoMoreData;

@end
