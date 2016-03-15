//
//  NSMutableURLRequest+Multipart.m
//  06-POST上传
//
//  Created by apple on 15/1/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSMutableURLRequest+Multipart.h"

/**随便的字符串作为分隔符*/
static NSString *boundary = @"xufeng-test";

@implementation NSMutableURLRequest (Multipart)


+ (instancetype)requestWithURL:(NSURL *)url andLoaclFilePath:(NSString *)loaclFilePath andFileName:(NSString *)fileName
{
    
    //step_2:创建request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:2.0f];
    // 2.1 指定post方法
    request.HTTPMethod = @"POST";
    
    // 2.2 拼接数据体
    NSMutableData *dataM = [NSMutableData data];
    NSString *str = [NSString stringWithFormat:@"\r\n--%@\r\n", boundary];
    [dataM appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    str = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\" \r\n", fileName];
    [dataM appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 这里直接指定为octet-stream，这样可以针对全部的文件格式
    str = @"Content-Type: application/octet-stream\r\n\r\n";
    [dataM appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 要上传图片的二进制
    [dataM appendData:[NSData dataWithContentsOfFile:loaclFilePath]];
    
    str = [NSString stringWithFormat:@"\r\n--%@--\r\n", boundary];
    [dataM appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 2.3 设置请求体
    request.HTTPBody = dataM;
    
    // 2.4 设置请求头
    NSString *headerStr = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:headerStr forHTTPHeaderField:@"Content-Type"];
    
    return request;
}


@end
