//
//  UserProfileViewModel.swift
//  Youth
//
//  Created by Lupu Cristian on 6/13/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public struct UserProfileViewModel {

    public let userViewModel: YouthUserViewModel
    public let locationViewModel: YouthLocationViewModel

    public let biography: String
    public let biographyIsVisible: Bool

    public let locationIsVisible: Bool

    public let likedSectionState: UserProfileSectionInfoState
    public let photosSectionState: UserProfileSectionInfoState
    public let collectionsSectionState: UserProfileSectionInfoState

    public let twitterButtonIsVisible: Bool
    public let instagramButtonIsVisible: Bool

}
