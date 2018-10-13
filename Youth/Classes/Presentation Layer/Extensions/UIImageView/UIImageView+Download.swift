//
//  UIImageView+Download.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import SDWebImage

extension UIImageView {
    func loadImage(with url: URL?,
                   placeholderImage placeholder: UIImage? = nil,
                   completion: ((UIImage?, Error?) -> Void)? = nil) {
        guard url != nil else {
            image = nil
            return
        }
        sd_setImage(with: url,
                    placeholderImage: placeholder)
        { [weak self] (image, error, cacheType, _) in
            completion?(image, error)
            if image != nil && cacheType == .none {
                self?.animateFadeInappearance()
            }
        }
    }
}
