//
//  ShortNumberFormatter.swift
//  Youth
//
//  Created by Cristian Lupu on 5/19/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Responsible to modify Int in minimal String format, in conformance with Youth style.
final class ShortNumberFormatter {
    private struct Abbrevation {
        let threshold: Double
        let divisor: Double
        let suffix: String
    }

    /**
     Get minimal formatted string from Int number, in conformance with Youth style
     
     - parameter number: Number to format.
     
     - returns: Formatted string.
     */
    func string(from number: Int64) -> String {
        let numFormatter = NumberFormatter()

        let abbreviations: [Abbrevation] = [
            .init(threshold: 0, divisor: 1, suffix: ""),
            .init(threshold: 1_000, divisor: 1_000, suffix: "K"),
            .init(threshold: 100_000, divisor: 1_000_000, suffix: "M"),
            .init(threshold: 100_000_000, divisor: 1_000_000_000, suffix: "B")
        ]

        let startValue = Double(abs(number))

        let abbreviation: Abbrevation = {
            var prevAbbreviation = abbreviations[0]

            for tmpAbbreviation in abbreviations {
                if startValue < tmpAbbreviation.threshold {
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

        return numFormatter.string(from: NSNumber(value: value)) ?? ""
    }
}
