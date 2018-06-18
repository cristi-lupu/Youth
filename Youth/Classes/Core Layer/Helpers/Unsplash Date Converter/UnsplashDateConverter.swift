//
//  UnsplashDateConverter.swift
//  Youth
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Converter for dates obtained with Unsplash API
public enum UnsplashDateConverter {

    private enum DateFormat: String {
        case dateFromString = "yyyy-MM-dd'T'HH:mm:ssZ"
        case stringFromDate = "EEE, d MMM y"
    }

    public static var timeZone: TimeZone {
        return TimeZone(identifier: "UTC")!
    }

    /**
     Convert string in date

     - parameter string: String to convert
    */
    public static func date(from string: String?) -> Date? {
        guard let _string = string else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = UnsplashDateConverter.DateFormat.dateFromString.rawValue
        dateFormatter.timeZone = UnsplashDateConverter.timeZone
        return dateFormatter.date(from: _string)
    }

    /**
     Convert date in string

     - parameter date: Date to convert
     */
    public static func formattedString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = UnsplashDateConverter.timeZone
        dateFormatter.dateFormat = UnsplashDateConverter.DateFormat.stringFromDate.rawValue
        return dateFormatter.string(from: date)
    }

}
