//
//  YouthLocationViewModelBuilder.swift
//  Youth
//
//  Created by Cristian Lupu on 6/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Responsible to build Youth Location View Model.
final class YouthLocationViewModelBuilder {
    /**
     Build YouthLocationViewModel.
     
     - parameter location: Location in `optional` string format
     
     - returns: Builded YouthLocationViewModel
     */
    func build(withLocation location: String?) -> YouthLocationViewModel {
        return YouthLocationViewModel(location: location ?? "")
    }

    /**
     Build YouthLocationViewModel.
     
     - parameter location: Location in `optional` UnsplashLocation format
     
     - returns: Builded YouthLocationViewModel
     */
    func build(withLocation location: Unsplash.Location?) -> YouthLocationViewModel {
        guard let location = location else {
            return YouthLocationViewModel(location: "")
        }

        var locationString = ""

        if let city = location.city {
            locationString = city
        }

        if let country = location.country {
            if locationString.isEmpty {
                locationString = country
            } else {
                locationString += ", " + country
            }
        }

        return YouthLocationViewModel(location: locationString)
    }
}
