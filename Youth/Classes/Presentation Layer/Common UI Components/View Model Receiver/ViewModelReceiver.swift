//
//  ViewModelReceiver.swift
//  Youth
//
//  Created by Lupu Cristian on 6/13/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// The protocol describes the object which receive and handle a arbitrary view model
public protocol ViewModelReceiver: class {

    /// Type of view model
    associatedtype ViewModelType

    /**
     Initialize object with view model

     - parameter viewModel: ViewModel of type ViewModelType
     */
    init(viewModel: ViewModelType)

    /**
     Update self object in conformance with view model

     - parameter viewModel: ViewModel of type ViewModelType
     */
    func updateInConformance(with viewModel: ViewModelType)

}
