//
//  MySessionConfiguration.m
//  DebugTools
//
//  Created by 璐 on 2022/7/27.
//

#import "LLSessionConfiguration.h"
#import <Foundation/Foundation.h>
#import "LLHttpProtocal.h"
#import <objc/runtime.h>

@interface LLSessionConfiguration()

@property (nonatomic, assign) BOOL isSwizzle;


@end

@implementation LLSessionConfiguration

+ (LLSessionConfiguration *) defaultConfiguration {
    static LLSessionConfiguration *staticConfiguration;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticConfiguration = [[LLSessionConfiguration alloc] init];
        
    });
    return staticConfiguration;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isSwizzle = NO;
    }
    return self;
}

- (void)load {
      self.isSwizzle=YES;
      Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?:NSClassFromString(@"NSURLSessionConfiguration");
      [self swizzleSelector:@selector(protocolClasses) fromClass:cls toClass:[self class]];
}

- (void)unload {
    self.isSwizzle=NO;
     Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?:NSClassFromString(@"NSURLSessionConfiguration");
     [self swizzleSelector:@selector(protocolClasses) fromClass:cls toClass:[self class]];
}

- (void)swizzleSelector:(SEL)selector fromClass:(Class)original toClass:(Class)stub{
    Method originalMethod = class_getInstanceMethod(original, selector);
    Method stubMethod = class_getInstanceMethod(stub, selector);
    if(!originalMethod || !stubMethod){
        [NSException raise:NSInternalInconsistencyException format:@"Could't load NSURLSessionConfiguration "];
    }

   //真正的替换在这里
    method_exchangeImplementations(originalMethod, stubMethod);
}

 //返回MyHttpProtocol
- (NSArray *)protocolClasses{
    return @[[LLHttpProtocal class]];
}

@end
