//
//  UserProfileInteractor.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class UserProfileInteractor {

	// MARK: Output

    public weak var output: UserProfileInteractorOutput?

    // MARK: Instagram App Opener

    public var instagramOpener: InstagramAppOpener?

    // MARK: Twitter Opener

    public var twitterOpener: TwitterAppOpener?

}

// MARK: UserProfileInteractorInput 

extension UserProfileInteractor: UserProfileInteractorInput {

    public func openInstagramUserProfile(username: String) {
        instagramOpener?.openApp(withData: username, completion: { (success, error) in
            print(success)
            print(error ?? "tip nui erroare instagram")
        })
    }

    public func openTwitterUserProfile(username: String) {
        twitterOpener?.openApp(withData: username, completion: { (success, error) in
            print(success)
            print(error ?? "tip nui erroare twitter")
        })
    }
    
}
