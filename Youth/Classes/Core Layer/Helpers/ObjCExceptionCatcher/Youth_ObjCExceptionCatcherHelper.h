//
//  Youth_ObjCExceptionCatcherHelper.h
//  Youth
//
//  Created by Lupu Cristian on 6/2/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Youth_ObjCExceptionCatcherHelper : NSObject

+ (void)try:(nonnull NS_NOESCAPE void(^)(void))tryBlock
      catch:(nonnull void(^)(NSException * _Nonnull))catchBlock
    finally:(nonnull void(^)(void))finallyBlock;

@end
