//
//  LLNetData.m
//  DebugTools
//
//  Created by 璐 on 2022/7/27.
//

#import "LLNetData.h"

@interface LLNetData() {
    dispatch_queue_t concurrent_queue;
    NSMutableArray *urlDic;
}

@end

@implementation LLNetData

+ (instancetype)config {
    static LLNetData *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[LLNetData alloc] init];
       
    });
    return config;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        urlDic = [NSMutableArray array];
        concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)addObject:(id)obj {
    dispatch_barrier_async(concurrent_queue, ^{
//        [self->urlDic addObject:obj];
        [[self mutableArrayValueForKey:@"urlDic"] addObject:obj];
        
    });
}

- (void)removeAllObject {
    dispatch_sync(concurrent_queue, ^{
//        [self->urlDic removeAllObjects];
        [[self mutableArrayValueForKey:@"urlDic"] removeAllObjects];
    });
    
}

- (NSArray *)allObject {
    return self->urlDic;
}

@end
