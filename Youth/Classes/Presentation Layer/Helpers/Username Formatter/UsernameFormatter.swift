//
//  UsernameFormatter.swift
//  Youth
//
//  Created by Cristian Lupu on 5/22/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

/// Responsible to modify username to conformance with Youth style
final class UsernameFormatter {
    /**
     Modify username in conformance with Youth style.
     
     - parameter text: Any text. Preferably an username.
     
     - returns: Formatted username.
     */
    func formattedUsername(_ text: String?) -> String {
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
