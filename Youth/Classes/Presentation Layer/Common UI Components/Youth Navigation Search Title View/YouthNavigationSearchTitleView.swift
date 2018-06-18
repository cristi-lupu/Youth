//
//  YouthNavigationSearchTitleView.swift
//  Youth
//
//  Created by Lupu Cristian on 6/1/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Navigation Search Title View. Use as title view on search screens.
public final class YouthNavigationSearchTitleView: UIView {

    public weak var textField: YouthTextField!

    // MARK: Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: Private methods

    private func commonInit() {
        backgroundColor = .clear

        let textField = YouthTextField()
        textField.textAlignment = .center

        addSubview(textField)

        textField.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }

        snp.makeConstraints { (maker) in
            maker.height.equalTo(30)
            maker.width.equalTo(220)
        }

        self.textField = textField
    }

    // MARK: Public methods

    /**
     Set search placeholder

     - parameter placeholder: Placeholder string
     */
    public func set(placeholder: String) {
        textField.placeholder = placeholder
    }

    /// Become First Responder
    public func textFieldBecomeFirstResponder() {
        textField.becomeFirstResponder()
    }

}
