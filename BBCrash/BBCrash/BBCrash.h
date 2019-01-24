//
//  BBCrash.h
//  BBCrash
//
//  Created by 程肖斌 on 2019/1/24.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBCrash : NSObject

/*
    单例,只能阻挡一次崩溃
    有些时候我们会发现崩溃了一次之后很难再复现，可以用这个来阻止一次崩溃
    还有的时候一些很隐蔽的地方，用户很少很少会触及，那些地方出了问题，也可以用这个来阻挡一次
    这个工具尽量在app启动的时候就监测着。[BBCrash sharedManager]就可以了
*/
+ (BBCrash *)sharedManager;

@end

