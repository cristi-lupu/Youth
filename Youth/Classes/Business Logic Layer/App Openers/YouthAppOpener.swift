//
//  YouthAppOpener.swift
//  Youth
//
//  Created by User678 on 5/29/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// App Opener Error
enum YouthAppOpenerError: Error {
    /// Application is not installed
    case appNotInstalled

    /// Could not create app URL
    case couldNotCreateAppURL
}

typealias AppOpenerActionCompletion = (_ success: Bool, _ error: YouthAppOpenerError?) -> Void

protocol YouthAppOpener {
    associatedtype DataType

    /**
     Open app with some information
     
     - parameter data: Information to send
     - parameter completion: Completion
     */
    func openApp(withData data: DataType, completion: AppOpenerActionCompletion)
}
