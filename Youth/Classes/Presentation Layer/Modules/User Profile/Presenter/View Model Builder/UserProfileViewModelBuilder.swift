//
//  UserProfileViewModelBuilder.swift
//  Youth
//
//  Created by Cristian Lupu on 6/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Responsible to build UserProfileViewModel
class UserProfileViewModelBuilder {
    
    private let userViewModelBuider: YouthUserViewModelBuider
    private let locationViewModelBuilder: YouthLocationViewModelBuilder
    private let shortNumberFormatter: ShortNumberFormatter
    
    /**
     Initialize builder
     
     - parameter userViewModelBuider: User view model builder
     - parameter locationViewModelBuilder: Location view model builder
     - parameter shortNumberFormatter: Short Number Formatter
     */
    init(userViewModelBuider: YouthUserViewModelBuider,
         locationViewModelBuilder: YouthLocationViewModelBuilder,
         shortNumberFormatter: ShortNumberFormatter) {
        self.userViewModelBuider = userViewModelBuider
        self.locationViewModelBuilder = locationViewModelBuilder
        self.shortNumberFormatter = shortNumberFormatter
    }
    
    /**
     Build shortNumberFormatter
     
     - parameter user: User object
     
     - returns: Builded UserProfileViewModel
     */
    func build(withUser user: UnsplashUser) -> UserProfileViewModel {
        let userViewModel = userViewModelBuider.build(withUser: user)
        let locationViewModel = locationViewModelBuilder.build(withLocation: user.location)
        
        let locationIsVisible = !locationViewModel.location.isEmpty
        
        let biography = user.bio ?? ""
        let biographyIsVisible = !biography.isEmpty
        
        let likedState: UserProfileSectionInfoState
        
        if let liked = user.totalLikes {
            likedState = .count(textFormat: shortNumberFormatter.string(from: liked))
        } else {
            likedState = .unknown
        }
        
        let photosState: UserProfileSectionInfoState
        
        if let photos = user.totalPhotos {
            photosState = .count(textFormat: shortNumberFormatter.string(from: photos))
        } else {
            photosState = .unknown
        }
        
        let collectionsState: UserProfileSectionInfoState
        
        if let collections = user.totalCollections {
            collectionsState = .count(textFormat: shortNumberFormatter.string(from: collections))
        } else {
            collectionsState = .unknown
        }
        
        let twitterButtonIsVisible = user.twitterUsername != nil
        let instagramButtonIsVisible = user.instagramUsername != nil
        
        return UserProfileViewModel(userViewModel: userViewModel,
                                    locationViewModel: locationViewModel,
                                    biography: biography,
                                    biographyIsVisible: biographyIsVisible,
                                    locationIsVisible: locationIsVisible,
                                    likedSectionState: likedState,
                                    photosSectionState: photosState,
                                    collectionsSectionState: collectionsState,
                                    twitterButtonIsVisible: twitterButtonIsVisible,
                                    instagramButtonIsVisible: instagramButtonIsVisible)
    }
    
}
