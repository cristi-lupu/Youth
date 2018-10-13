//
//  YouthNavigationSearchTitleView.swift
//  Youth
//
//  Created by Cristian Lupu on 6/1/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Navigation Search Title View. Use as title view on search screens.
final class YouthNavigationSearchTitleView: UIView {
    
    weak var textField: YouthTextField!
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
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
    func set(placeholder: String) {
        textField.placeholder = placeholder
    }
    
    /// Become First Responder
    func textFieldBecomeFirstResponder() {
        textField.becomeFirstResponder()
    }
    
}
