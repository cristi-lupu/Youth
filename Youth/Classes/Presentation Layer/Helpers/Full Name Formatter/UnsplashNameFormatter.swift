//
//  FullNameFormatter.swift
//  Youth
//
//  Created by Cristian Lupu on 5/12/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Responsible to modify fullname in conformance with Youth style
final class FullNameFormatter {
    
    /**
     Modify full name if needed.
     
     - parameter name: `Optional` name string
     - parameter firstName: `Optional` first name string
     - parameter lastName: `Optional` last name string
     
     - returns: Modified fullname
     */
    func fullName(withName name: String?, firstName: String?, lastName: String?) -> String {
        if let name = name {
            return name
        }
        
        var _firstName = ""
        
        if let fName = firstName {
            _firstName = fName
        }
        
        var _lastName = ""
        
        if let lName = lastName {
            _lastName = lName
        }
        
        if _firstName.isEmpty {
            return _lastName
        } else if _lastName.isEmpty {
            return _firstName
        } else {
            return _firstName + " " + _lastName
        }
    }
    
}
