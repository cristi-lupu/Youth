//
//  Youth_ObjCExceptionCatcherHelper.m
//  Youth
//
//  Created by Cristian Lupu on 6/2/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

#import "Youth_ObjCExceptionCatcherHelper.h"

@implementation Youth_ObjCExceptionCatcherHelper

+ (void)try:(NS_NOESCAPE void(^)(void))tryBlock
      catch:(void(^)(NSException *))catchBlock
    finally:(void(^)(void))finallyBlock {
    @try {
        tryBlock();
    }
    @catch (NSException *exception) {
        catchBlock(exception);
    }
    @finally {
        finallyBlock();
    }
}

@end
