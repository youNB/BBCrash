//
//  BBCrash.m
//  BBCrash
//
//  Created by 程肖斌 on 2019/1/24.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import "BBCrash.h"

@implementation BBCrash

//单例
+ (BBCrash *)sharedManager{
    static BBCrash *manager = nil;
    static dispatch_once_t once_t = 0;
    dispatch_once(&once_t, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (instancetype)init{
    if([super init]){//收录了一小部分，有其他的异常，可以继续添加
        NSSetUncaughtExceptionHandler(&catchException);
        
        signal(SIGABRT, &signalException);
        signal(SIGILL,  &signalException);
        signal(SIGSEGV, &signalException);
        signal(SIGFPE,  &signalException);
        signal(SIGBUS,  &signalException);
        signal(SIGPIPE, &signalException);
        signal(SIGINT,  &signalException);
    }
    return self;
}

void catchException(NSException *exception){
    CFRunLoopRef ref = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(ref);
    while (1) {
        for(NSString *mode in (__bridge NSArray *)allModes){
            CFRunLoopRunInMode((CFStringRef)mode, 0.016, NO);
        }
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
    CFRelease(allModes);//不要怀疑这句话，测试了一下，没有这个好像还就不行，虽然上面是死循环
#pragma clang diagnostic pop
}

void signalException(int signal){
    NSException *exception = [NSException exceptionWithName:@"exceptionName"
                                                     reason:@"signal crash"
                                                   userInfo:@{}];
    catchException(exception);
}

@end
