//
//  YouthUserView.swift
//  Youth
//
//  Created by Lupu Cristian on 6/10/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit
import SnapKit

/// Describe an object who receive actions from YouthUserView
public protocol YouthUserViewDelegate: class {

    /**
     Tell that user view did tapped

     - parameter userView: View that did tapped
    */
    func didTapUserView(_ userView: YouthUserView)

}

/// Youth User View. Used for showing general information about user.
public final class YouthUserView: UIView {

    // MARK: Deinitialization

    deinit {
        // Remove gesture regcognizers
        tapGesture.removeTarget(nil, action: nil)
        removeGestureRecognizer(tapGesture)
    }

    // MARK: Private properties

    private weak var userAvatarImageView: UIImageView!
    private weak var userNamesStackView: UIStackView!
    private weak var userFullNameLabel: UILabel!
    private weak var usernameLabel: UILabel!
    private weak var tapGesture: UITapGestureRecognizer!

    private var configuredUserAvatarImageView: UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.masksToBounds = true
        return imageView
    }

    private var configuredUserNamesStackView: UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }

    private var configuredUserFullNameLabel: UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = YouthFonts.avenirNextBold(size: 10).font
        label.textAlignment = .left
        return label
    }

    private var configuredUsernameLabel: UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = YouthFonts.avenirNextRegular(size: 10).font
        label.textAlignment = .left
        return label
    }

    // MARK: Public properties

    /// Delegate
    public weak var delegate: YouthUserViewDelegate?

    // MARK: Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: View life-cycle

    public override func layoutSubviews() {
        super.layoutSubviews()
        // Round userAvatarImageView
        userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.height / 2.0
    }

    // MARK: Private methods

    private func commonInit() {
        backgroundColor = .clear

        let userImageView = configuredUserAvatarImageView

        addSubview(userImageView)

        userImageView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.height.equalToSuperview()
            maker.width.equalTo(userImageView.snp.height)
        }

        let namesStackView = configuredUserNamesStackView

        addSubview(namesStackView)

        namesStackView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(userImageView.snp.trailing).offset(8)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.trailing.equalToSuperview()
        }

        let fullNameLabel = configuredUserFullNameLabel

        namesStackView.addArrangedSubview(fullNameLabel)

        let usernameLabel = configuredUsernameLabel

        namesStackView.addArrangedSubview(usernameLabel)

        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapSelf(_:)))

        addGestureRecognizer(tapGesture)

        self.userAvatarImageView = userImageView
        self.userNamesStackView = namesStackView
        self.userFullNameLabel = fullNameLabel
        self.usernameLabel = usernameLabel
        self.tapGesture = tapGesture
    }

    // MARK: Actions

    @objc private func didTapSelf(_ gestureRecognizer: UITapGestureRecognizer) {
        delegate?.didTapUserView(self)
    }

    // MARK: Public methods

    /**
     Set user avatar image url

     - parameter userAvatarImageURL: Image URL
     */
    public func set(userAvatarImageURL: URL) {
        userAvatarImageView.af_setImage(withURL: userAvatarImageURL,
                                        imageTransition: .crossDissolve(0.3))
    }

    /**
     Set user fullname

     - parameter userFullName: User fullname
     */
    public func set(userFullName: String) {
        userFullNameLabel.text = userFullName
    }

    /**
     Set username

     - parameter username: Username
     */
    public func set(username: String) {
        usernameLabel.text = username
    }

}

// MARK: ViewModelReceiver

extension YouthUserView: ViewModelReceiver {

    public typealias ViewModelType = YouthUserViewModel

    public convenience init(viewModel: YouthUserViewModel) {
        self.init()
        updateSelf(viewModel: viewModel)
    }

    public func updateInConformance(with viewModel: YouthUserViewModel) {
        updateSelf(viewModel: viewModel)
    }

    private func updateSelf(viewModel: YouthUserViewModel) {
        if let url = viewModel.userAvatarImageURL {
            set(userAvatarImageURL: url)
        }

        set(userFullName: viewModel.userFullname)
        set(username: viewModel.username)
    }

}
