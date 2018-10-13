//
//  YouthTextField.swift
//  Youth
//
//  Created by Cristian Lupu on 6/1/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Custom UITextField with Youth Style.
final class YouthTextField: UITextField {
    
    override var tintColor: UIColor! {
        didSet {
            bottomBorderView?.backgroundColor = tintColor
        }
    }
    
    // MARK: Private properties
    
    private weak var bottomBorderView: UIView?
    
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
        borderStyle = .none
        tintColor = .black
        backgroundColor = .clear
        bottomBorderView = addBottomBorderView(height: 1)
        
        font = YouthFonts.avenirNextDemiBold(size: 12).font
    }
    
    private func addBottomBorderView(height: CGFloat) -> UIView {
        let border = UIView()
        border.backgroundColor = tintColor
        
        addSubview(border)
        
        border.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(height)
        }
        
        return border
    }
    
}
