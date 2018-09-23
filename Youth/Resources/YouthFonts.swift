//
//  YouthFonts.swift
//  Youth
//
//  Created by Lupu Cristian on 6/10/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

enum YouthFonts {
    case avenirNextRegular(size: CGFloat)
    case avenirNextMedium(size: CGFloat)
    case avenirNextBold(size: CGFloat)
    case avenirNextDemiBold(size: CGFloat)
    
    var font: UIFont {
        switch self {
        case let .avenirNextRegular(size):
            return UIFont(name: "AvenirNext-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        case let .avenirNextMedium(size):
            return UIFont(name: "AvenirNext-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        case let .avenirNextBold(size):
            return UIFont(name: "AvenirNext-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        case let .avenirNextDemiBold(size):
            return UIFont(name: "AvenirNext-DemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
