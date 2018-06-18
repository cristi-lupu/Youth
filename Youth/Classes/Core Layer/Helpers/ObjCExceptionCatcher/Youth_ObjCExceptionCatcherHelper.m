//
//  Youth_ObjCExceptionCatcherHelper.m
//  Youth
//
//  Created by Lupu Cristian on 6/2/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
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
