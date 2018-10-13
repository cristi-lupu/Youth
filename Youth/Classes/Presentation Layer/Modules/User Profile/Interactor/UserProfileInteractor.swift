//
//  UserProfileInteractor.swift
//  Youth
//
//  Created by Cristian Lupu on 19/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class UserProfileInteractor {
    
    // MARK: Output
    
    weak var output: UserProfileInteractorOutput?
    
    // MARK: Instagram App Opener
    
    var instagramOpener: InstagramAppOpener?
    
    // MARK: Twitter Opener
    
    var twitterOpener: TwitterAppOpener?
    
}

// MARK: UserProfileInteractorInput 

extension UserProfileInteractor: UserProfileInteractorInput {
    
    func openInstagramUserProfile(username: String) {
        instagramOpener?.openApp(withData: username, completion: { (success, error) in
            print(success)
            print(error ?? "tip nui erroare instagram")
        })
    }
    
    func openTwitterUserProfile(username: String) {
        twitterOpener?.openApp(withData: username, completion: { (success, error) in
            print(success)
            print(error ?? "tip nui erroare twitter")
        })
    }
    
}
