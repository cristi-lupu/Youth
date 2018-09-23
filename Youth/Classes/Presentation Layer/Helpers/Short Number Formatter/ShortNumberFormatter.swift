//
//  ShortNumberFormatter.swift
//  Youth
//
//  Created by Lupu Cristian on 5/19/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Responsible to modify Int in minimal String format, in conformance with Youth style.
final class ShortNumberFormatter {
    
    /**
     Get minimal formatted string from Int number, in conformance with Youth style
     
     - parameter number: Number to format.
     
     - returns: Formatted string.
     */
    func string(from number: Int64) -> String {
        let numFormatter = NumberFormatter()
        
        typealias Abbrevation = (threshold: Double, divisor: Double, suffix: String)
        
        let abbreviations: [Abbrevation] = [(0, 1, ""),
                                            (1000.0, 1000.0, "K"),
                                            (100_000.0, 1_000_000.0, "M"),
                                            (100_000_000.0, 1_000_000_000.0, "B")]
        
        let startValue = Double(abs(number))
        
        let abbreviation: Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                
                prevAbbreviation = tmpAbbreviation
            }
            
            return prevAbbreviation
        }()
        
        let value = Double(number) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1
        
        return numFormatter.string(from: NSNumber(value:value)) ?? ""
    }
    
}
