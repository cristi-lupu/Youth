//
//  TwitterOpener.swift
//  Youth
//
//  Created by User678 on 5/29/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Responsible to open Twitter App
final class TwitterAppOpener: YouthAppOpener {
    typealias DataType = String

    func openApp(withData data: String, completion: AppOpenerActionCompletion) {
        guard let url = URL(string: "twitter://user?screen_name=" + data) else {
            completion(false, .couldNotCreateAppURL)
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
            completion(true, nil)
        } else {
            completion(false, .appNotInstalled)
        }
    }
}
