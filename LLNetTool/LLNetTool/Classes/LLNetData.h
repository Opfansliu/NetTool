//
//  LLNetData.h
//  DebugTools
//
//  Created by 璐 on 2022/7/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLNetData : NSObject

+ (instancetype)config;
- (void)addObject:(id)obj;
- (void)removeAllObject;
- (NSArray *)allObject;

@end

NS_ASSUME_NONNULL_END
