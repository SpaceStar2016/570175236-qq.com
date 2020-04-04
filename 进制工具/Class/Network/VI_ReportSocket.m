//
//  FeiYu_ReportSocket.m
//  FeiYuCam
//
//  Created by ZhongSpace on 2018/1/23.
//  Copyright © 2018年 ZhongSpace. All rights reserved.
//

#import "VI_ReportSocket.h"
#import "GCDAsyncSocket.h"
#import "VI_Device_Observer.h"
#import "VI_NotificationModel.h"
//#import "CameraNotifyModel.h"
//#import "CameraGlobalSpyManager.h"
@interface VI_ReportSocket()<GCDAsyncSocketDelegate>

@property (strong, nonatomic) GCDAsyncSocket *socket;
@property (strong, nonatomic) NSMutableArray *clientSockets;//保存客户端scoket
@end

@implementation VI_ReportSocket

- (NSMutableArray *)clientSockets
{
    if (_clientSockets == nil) {
        _clientSockets = [[NSMutableArray alloc]init];
    }
    return _clientSockets;
}
+(instancetype)shareReportSocket
{
    static dispatch_once_t onceToken;
    static VI_ReportSocket * instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[VI_ReportSocket alloc] init];
    });
    return instance;
}

-(instancetype)init
{
    if (self = [super init]) {
        
        [self start];
        
    }
    return self;
}

-(void)resetReportSocket
{
    if (!self.socket) {
        [self start];
    }
    else
    {
        NSError *error = nil;
        if (![self.socket isDisconnected]) {
            [self.socket disconnect];
        }
        [self.socket acceptOnPort:5678 error:&error];
        
        //3.开启服务(实质第二步绑定端口的同时默认开启服务)
        if (error == nil)
        {
            NSLog(@"开启成功");
        }
        else
        {
            NSLog(@"开启失败");
        }
    }
}

- (void)start
{
    //1.创建scoket对象
    GCDAsyncSocket *serviceScoket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    
    //2.绑定端口(5288)
    //端口任意，但遵循有效端口原则范围：0~65535，其中0~1024由系统使用或者保留端口，开发中建议使用1024以上的端口
    NSError *error = nil;
    [serviceScoket acceptOnPort:5678 error:&error];
    
    //3.开启服务(实质第二步绑定端口的同时默认开启服务)
    if (error == nil)
    {
        NSLog(@"开启成功");
    }
    else
    {
        NSLog(@"开启失败");
    }
    self.socket = serviceScoket;
}

//连接到客户端socket
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    //sock 服务端的socket
    //newSocket 客户端连接的socket
    NSLog(@"%@----%@",sock, newSocket);
    
    //1.保存连接的客户端socket(否则newSocket释放掉后链接会自动断开)
    [self.clientSockets addObject:newSocket];

    //2.监听客户端有没有数据上传
    //-1代表不超时
    //tag标示作用
    [newSocket readDataWithTimeout:-1 tag:0];
}

//接收到客户端数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    //1.接受到用户数据
    NSError * err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
    }
    else
    {
        /***
         event = 0;
         mode = 24;
         param = 263;
         pasttime = 1530182193;
         setOpt = 4;
         state = 2;
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"dic=====%@",dic);
           VI_NotificationModel * model =  [[VI_NotificationModel alloc] initWithDict:dic];
            [[VI_Device_Observer shareObserver] addModel:model];
        });
        
    }

    //CocoaAsyncSocket每次读取完成后必须调用一次监听数据方法
    [sock readDataWithTimeout:-1 tag:0];
}

-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"socketDidDisconnect");
}



@end
