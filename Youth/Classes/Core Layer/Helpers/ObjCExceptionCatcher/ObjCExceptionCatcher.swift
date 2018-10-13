//
//  ObjCExceptionCatcher.swift
//  Youth
//
//  Created by Cristian Lupu on 6/2/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Responsible to catch ObjC Exceptions
final class ObjCExceptionCatcher {
    
    static func tryClosure(tryClosure: () -> (),
                           catchClosure: @escaping (NSException) -> (),
                           finallyClosure: @escaping () -> () = {}) {
        Youth_ObjCExceptionCatcherHelper.`try`(tryClosure,
                                               catch: catchClosure,
                                               finally: finallyClosure)
    }
    
}
