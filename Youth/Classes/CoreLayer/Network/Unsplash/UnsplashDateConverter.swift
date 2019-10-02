//
//  Unsplash+DateConverter.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    /// Converter for dates obtained with Unsplash API
    enum DateConverter {
        private enum Format: String {
            case dateFromString = "yyyy-MM-dd'T'HH:mm:ssZ"
            case stringFromDate = "EEE, d MMM y"
        }

        static var timeZone: TimeZone {
            return TimeZone(identifier: "UTC")!
        }

        /**
         Convert string in date

         - parameter string: String to convert
         */
        static func date(from string: String?) -> Date? {
            guard let string = string else { return nil }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateConverter.Format.dateFromString.rawValue
            dateFormatter.timeZone = DateConverter.timeZone

            return dateFormatter.date(from: string)
        }

        /**
         Convert date in string

         - parameter date: Date to convert
         */
        static func formattedString(from date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = DateConverter.timeZone
            dateFormatter.dateFormat = DateConverter.Format.stringFromDate.rawValue

            return dateFormatter.string(from: date)
        }
    }
}
