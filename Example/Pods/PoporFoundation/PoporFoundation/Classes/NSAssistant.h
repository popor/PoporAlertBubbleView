//
//  NSAssistant.h
//  wanzi
//
//  Created by popor on 12-3-19.
//V1.0

#import <Foundation/Foundation.h>
#import "PrefixOs.h"

@interface NSAssistant : NSObject

/*
 断点调试的时候,推荐使用chisel。或者配合Injection3使用以下方法。
 */
+ (void)NSLogEntity:(id)theClassEntity;
+ (void)NSLogEntity:(id)theClassEntity title:(NSString *)title;

/**
 默认忽略__开头的参数.
 后来一般使用JsonModel来映射model,兼容性更高.
 */
+ (void)setFullEntity:(id)theClassEntity withJson:(id)theJsonObject;

/**
 以下接口不对参数正确性判断,需要自己审核dic.
 */
+ (void)setVC:(VC_CLASS *)vc dic:(id)dic;
+ (void)setEntity:(id)entity dic:(id)dic;

@end


