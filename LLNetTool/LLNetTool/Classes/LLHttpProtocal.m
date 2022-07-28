//
//  MyHttpProtocal.m
//  DebugTools
//
//  Created by 璐 on 2022/7/27.
//

#import "LLHttpProtocal.h"
#import <Foundation/Foundation.h>
#import "LLNetData.h"

@interface LLHttpProtocal()<NSURLSessionDataDelegate>

@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSString *urlDescribe;

@end

@implementation LLHttpProtocal


+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString *scheme = [[request URL] scheme];
    if ([[scheme lowercaseString] isEqualToString:@"http"] || [[scheme lowercaseString] isEqualToString:@"https"]) {
        if ([NSURLProtocol propertyForKey:@"processed" inRequest:request]) {
            return NO;
        }
        return YES;
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *duplicatedRequest;
    duplicatedRequest = [request mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:@"processed" inRequest:duplicatedRequest];
    NSLog(@"%@", request.HTTPBody);
    return (NSURLRequest *)duplicatedRequest;
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
//    NSLog(@"--data received");
    
    NSError *error = nil;
    NSString *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
//        NSLog(@"error occured!--%@", error);
        self.urlDescribe = [self.urlDescribe stringByAppendingFormat:@"\nerror:%@", error];
        [[LLNetData config] addObject:self.urlDescribe];
        NSLog(@"--%@", self.urlDescribe);
        
        return;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"nsdata is %@", jsonString);
    self.urlDescribe = [self.urlDescribe stringByAppendingFormat:@"\nresult:%@", jsonString];
    NSLog(@"--%@", self.urlDescribe);
    [[LLNetData config] addObject:self.urlDescribe];
}

- (void)startLoading {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self.request.allHTTPHeaderFields allKeys] options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    self.urlDescribe = [NSString stringWithFormat:@"\nurl:%@\n \nmethod:%@ \nheader:%@", self.request.URL, self.request.HTTPMethod, jsonString];
    
    NSMutableURLRequest *newRequest = [self.request mutableCopy];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    self.task = [session dataTaskWithRequest:newRequest];
    [self.task resume];
}

- (void)stopLoading {
    [self.task cancel];
}



@end
