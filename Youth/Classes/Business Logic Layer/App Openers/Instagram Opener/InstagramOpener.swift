//
//  InstagramOpener.swift
//  Youth
//
//  Created by User678 on 5/29/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Responsible to open Instagram App
public class InstagramAppOpener: YouthAppOpener {

    public typealias DataType = String

    public func openApp(withData data: String, completion: AppOpenerActionCompletion) {
        guard let url = URL(string: "instagram://user?username=" + data) else {
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
