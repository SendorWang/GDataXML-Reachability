//
//  XXZNetwork.h
//  网络应用编程
//
//  Created by Zachary on 15/9/13.
//  Copyright (c) 2015年 www.xxzd.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXZNetwork : NSObject

/*!
 @method
 @abstract 判断网络：无网络，3G/4G，WIFI
 @discussion 直接调用，返回0，1，2分别代表无网络，3G/4G，WIFI
 @param nil
 @param nil
 @result NSInteger
 */
+ (NSInteger)network;

@end
