//
//  UIColorInputError.swift
//  Youth
//
//  Created by Cristian Lupu on 5/12/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

enum UIColorInputError: Error {
    case missingHashMarkAsPrefix(String)
    case unableToScanHexValue(String)
    case mismatchedHexStringLength(String)
    // swiftlint:disable:next identifier_name
    case unableToOutputHexStringForWideDisplayColor
}

extension UIColorInputError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingHashMarkAsPrefix(let hex):
            return "Invalid RGB string, missing '#' as prefix in \(hex)"

        case .unableToScanHexValue(let hex):
            return "Scan \(hex) error"

        case .mismatchedHexStringLength(let hex):
            return "Invalid RGB string from \(hex), number of characters after '#' should be either 3, 4, 6 or 8"

        case .unableToOutputHexStringForWideDisplayColor:
            return "Unable to output hex string for wide display color"
        }
    }
}
