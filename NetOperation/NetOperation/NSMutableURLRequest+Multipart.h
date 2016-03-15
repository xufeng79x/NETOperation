//
//  NSMutableURLRequest+Multipart.h
//  06-POST上传
//
//  Created by apple on 15/1/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableURLRequest (Multipart)

/**
 url: 要上传的服务器的地址
 loaclFilePath: 要上传的文件的全路径
 fileName：保存到服务器的文件名
 */
+ (instancetype)requestWithURL:(NSURL *)url andLoaclFilePath:(NSString *)loaclFilePath andFileName:(NSString *)fileName;


@end