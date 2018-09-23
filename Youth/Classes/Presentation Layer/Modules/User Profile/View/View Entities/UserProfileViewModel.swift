//
//  UserProfileViewModel.swift
//  Youth
//
//  Created by Lupu Cristian on 6/13/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

struct UserProfileViewModel {
    
    let userViewModel: YouthUserViewModel
    let locationViewModel: YouthLocationViewModel
    
    let biography: String
    let biographyIsVisible: Bool
    
    let locationIsVisible: Bool
    
    let likedSectionState: UserProfileSectionInfoState
    let photosSectionState: UserProfileSectionInfoState
    let collectionsSectionState: UserProfileSectionInfoState
    
    let twitterButtonIsVisible: Bool
    let instagramButtonIsVisible: Bool
    
}
