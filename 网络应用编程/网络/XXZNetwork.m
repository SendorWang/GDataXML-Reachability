//
//  XXZNetwork.m
//  网络应用编程
//
//  Created by Zachary on 15/9/13.
//  Copyright (c) 2015年 www.xxzd.com. All rights reserved.
//

#import "XXZNetwork.h"
#import "Reachability.h"

@implementation XXZNetwork

+ (NSInteger)network {
    NSString *hostName = @"www.baidu.com";
    Reachability *reachability = [Reachability reachabilityWithHostName:hostName];
    
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
            return 0;
            break;
        case ReachableViaWWAN:
            return 1;
            break;
        case ReachableViaWiFi:
            return 2;
            break;
            
        default:
            break;
    }
}

@end
