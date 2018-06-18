//
//  UsernameFormatter.swift
//  Youth
//
//  Created by Lupu Cristian on 5/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Responsible to modify username to conformance with Youth style
public class UsernameFormatter {

    /**
     Modify username in conformance with Youth style.

     - parameter text: Any text. Preferably an username.

     - returns: Formatted username.
     */
    public func formattedUsername(_ text: String?) -> String {
        guard let username = text else {
            return ""
        }

        if username.hasPrefix("@") {
            return username
        } else {
            return "@" + username
        }
    }

}
