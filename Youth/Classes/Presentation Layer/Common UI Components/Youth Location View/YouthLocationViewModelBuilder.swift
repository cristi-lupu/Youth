//
//  YouthLocationViewModelBuilder.swift
//  Youth
//
//  Created by Lupu Cristian on 6/13/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
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
    func build(withLocation location: UnsplashLocation?) -> YouthLocationViewModel {
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
