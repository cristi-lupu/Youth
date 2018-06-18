//
//  CollectionLoadingView.swift
//  Youth
//
//  Created by Lupu Cristian on 6/1/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class CollectionLoadingView: UICollectionReusableView, NibReusable {

    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!

    public func startAnimating() {
        activityIndicatorView.startAnimating()
    }

    public func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
    
}
