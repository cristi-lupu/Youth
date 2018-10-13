//
//  CollectionLoadingView.swift
//  Youth
//
//  Created by Cristian Lupu on 6/1/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class CollectionLoadingView: UICollectionReusableView, NibReusable {
    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!
    
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
}
