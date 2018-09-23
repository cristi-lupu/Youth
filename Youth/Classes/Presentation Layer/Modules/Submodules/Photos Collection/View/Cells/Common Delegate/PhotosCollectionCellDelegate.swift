//
//  PhotosCollectionCellDelegate.swift
//  Youth
//
//  Created by Lupu Cristian on 5/20/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Responsible to receive PhotosCollectionCell actions
protocol PhotosCollectionCellDelegate: class {
    
    /**
     Did tap image
     
     - parameter cell: Cell tapped
     */
    func didTapImage(on cell: UICollectionViewCell)
    
}
