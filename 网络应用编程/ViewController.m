//
//  ViewController.m
//  网络应用编程
//
//  Created by Zachary on 15/9/13.
//  Copyright (c) 2015年 www.xxzd.com. All rights reserved.
//

#import "ViewController.h"
#import "XXZNetwork.h"
#import "GDataXMLNode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self parseJson];
    NSMutableArray *needData = [self parseXML];
    NSLog(@"needData = %@", needData);
}

//XML解析
- (NSMutableArray *)parseXML {
    NSMutableArray *needArr = [NSMutableArray array];
    
    //导入本地xml文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"student" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data encoding:NSUTF8StringEncoding error:&error];
    if (doc == nil) {
        NSLog(@"xml文件错误！");
        return 0;
    }
    
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    //获取子节点
    NSArray *infoListArr = [rootElement elementsForName:@"infoList"];
    
    GDataXMLElement *infoListElement = [infoListArr objectAtIndex:0];
    NSArray *nameArr = [infoListElement elementsForName:@"info"];

    for (GDataXMLElement *element in nameArr) {
        NSMutableDictionary *needDict = [NSMutableDictionary dictionary];
        
        NSString *name = [[[element elementsForName:@"name"] objectAtIndex:0] stringValue];
        NSString *sex = [[[element elementsForName:@"sex"] objectAtIndex:0] stringValue];
        NSString *age = [[[element elementsForName:@"age"] objectAtIndex:0] stringValue];
        
        [needDict setObject:name forKey:@"name"];
        [needDict setObject:sex forKey:@"sex"];
        [needDict setObject:age forKey:@"age"];
        
        NSArray *courseArr = [element elementsForName:@"course"];
        if (courseArr) {
            for (GDataXMLElement *element in courseArr) {//
                NSMutableDictionary *courseDict = [NSMutableDictionary dictionary];
                
                NSString *math = [[[element elementsForName:@"math"] objectAtIndex:0] stringValue];
                NSString *english = [[[element elementsForName:@"english"] objectAtIndex:0] stringValue];
                NSString *chinese = [[[element elementsForName:@"chinese"] objectAtIndex:0] stringValue];
                
                [courseDict setObject:math forKey:@"math"];
                [courseDict setObject:english forKey:@"english"];
                [courseDict setObject:chinese forKey:@"chinese"];
                
                [needDict setObject:courseDict forKey:@"course"];
            }
        }
        
        [needArr addObject:needDict];
    }
    
    return needArr;
}

//Json解析
- (void)parseJson {
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"person" ofType:@"json"]];
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"json = %@ \n class = %@", json, NSStringFromClass([json class]));
}

//判断网络
- (void)isNetwork {
    NSInteger isNetwork = [XXZNetwork network];
    switch (isNetwork) {
        case 0:
            NSLog(@"无网络");
            break;
        case 1:
            NSLog(@"3G/4G网络");
            break;
        case 2:
            NSLog(@"WIFI网络");
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
