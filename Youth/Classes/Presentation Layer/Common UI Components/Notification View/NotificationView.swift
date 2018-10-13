//
//  NotificationView.swift
//  Youth
//
//  Created by Cristian Lupu on 6/18/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Notification View
final class NotificationView: UIView {
    
    // MARK: Private properties
    
    private weak var titleLabel: UILabel!
    
    private var configuredTitleLabel: UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.font = YouthFonts.avenirNextDemiBold(size: 14).font
        label.textColor = .white
        return label
    }
    
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
        backgroundColor = .black
        
        let titleLabel = configuredTitleLabel
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        snp.makeConstraints { (maker) in
            maker.height.equalTo(40)
        }
        
        self.titleLabel = titleLabel
    }
    
    // MARK: Public methods
    
    /**
     Set title
     
     - parameter title: Title string
     */
    func set(title: String) {
        titleLabel.text = title
    }
}
