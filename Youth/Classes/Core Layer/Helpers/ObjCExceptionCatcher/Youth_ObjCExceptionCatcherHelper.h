//
//  Youth_ObjCExceptionCatcherHelper.h
//  Youth
//
//  Created by Cristian Lupu on 6/2/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Youth_ObjCExceptionCatcherHelper : NSObject

+ (void)try:(nonnull NS_NOESCAPE void(^)(void))tryBlock
      catch:(nonnull void(^)(NSException * _Nonnull))catchBlock
    finally:(nonnull void(^)(void))finallyBlock;

@end
