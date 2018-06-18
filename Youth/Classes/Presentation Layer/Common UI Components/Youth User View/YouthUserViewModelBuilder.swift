//
//  YouthUserViewModelBuilder.swift
//  Youth
//
//  Created by Lupu Cristian on 6/13/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Responsible to build YouthUserViewModel
public final class YouthUserViewModelBuider {

    // MARK: Dependencies

    private let nameFormatter: FullNameFormatter
    private let usernameFormatter: UsernameFormatter

    /**
     Initialize builder with fullname formatter and username formatter

     - parameter fullNameFormatter: Fullname formatter
     - parameter usernameFormatter: Username formatter
     */
    public init(fullNameFormatter: FullNameFormatter,
                usernameFormatter: UsernameFormatter) {
        nameFormatter = fullNameFormatter
        self.usernameFormatter = usernameFormatter
    }

    /**
     Build YouthUserViewModel.

     - parameter user: User in `optional` UnsplashUser format

     - returns: Builded YouthUserViewModel
     */
    public func build(withUser user: UnsplashUser?) -> YouthUserViewModel {
        guard let user = user else {
            return YouthUserViewModel(userAvatarImageURL: nil,
                                      userFullname: "",
                                      username: "")
        }
        
        let userImageURL: URL?

        if let url = user.profileImage?.large {
            userImageURL = url
        } else if let url = user.profileImage?.medium {
            userImageURL = url
        } else if let url = user.profileImage?.small {
            userImageURL = url
        } else {
            userImageURL = nil
        }

        let userFullName = nameFormatter.fullName(withName: user.name,
                                                  firstName: user.firstName,
                                                  lastName: user.lastName)

        let username = usernameFormatter.formattedUsername(user.username)

        return YouthUserViewModel(userAvatarImageURL: userImageURL,
                                  userFullname: userFullName,
                                  username: username)
    }

}
