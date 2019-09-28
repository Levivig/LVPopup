//
//  Popup.swift
//  Template
//
//  Created by Levente Vig on 2019. 09. 28..
//  Copyright © 2019. levivig. All rights reserved.
//

import SnapKit
import SwifterSwift
import UIKit

class Popup: BasePopup {
    
    // MARK: - Private properties -
    
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var leftButton: RoundButton!
    private var rightButton: RoundButton!
    
    private var buttonHeight: Int = 44
    private var buttonOffset: Int = 16
    private var buttonVerticalSpacing = 20
    private var buttonDistance = 8
    
    // MARK: - Init -
    
    // swiftlint:disable function_default_parameter_at_end
    init(title: String,
         subtitle: String? = nil,
         descriptionText: String,
         leftButtonModel: RoundButtonBindable,
         rightButtonModel: RoundButtonBindable? = nil) {
        super.init(frame: .zero)
        initialize()
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        descriptionLabel.text = descriptionText
        leftButton.bind(model: leftButtonModel)
        if let model = rightButtonModel {
            rightButton.bind(model: model)
            setRightButton(hidden: false)
        } else {
            setRightButton(hidden: true)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        initTitleLabel()
        initSubtitleLabel()
        initDescriptionLabel()
        initLeftButton()
        initRightButton()
    }
    
    private func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func initSubtitleLabel() {
        subtitleLabel = UILabel()
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    private func initDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(12)
        }
    }
    
    private func initLeftButton() {
        leftButton = RoundButton(frame: .zero)
        
        addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(buttonOffset)
            make.width.equalTo(self.snp.width).multipliedBy(0.5).offset(-buttonOffset-buttonDistance)
            make.height.equalTo(buttonHeight)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(buttonVerticalSpacing)
            make.bottom.equalToSuperview().offset(-buttonVerticalSpacing)
        }
    }
    
    private func initRightButton() {
        rightButton = RoundButton(frame: .zero)
        
        addSubview(rightButton)
        rightButton.snp.remakeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(0.5).offset(-buttonOffset-buttonDistance)
            make.trailing.equalToSuperview().offset(-buttonOffset)
            make.height.equalTo(buttonHeight)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(buttonVerticalSpacing)
            make.bottom.equalToSuperview().offset(-buttonVerticalSpacing)
        }
    }
    
    // MARK: - Layout -
    
    private func setRightButton(hidden: Bool) {
        rightButton.isHidden = hidden
        if hidden {
            leftButton.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(buttonOffset)
                make.centerX.equalToSuperview()
                make.height.equalTo(buttonHeight)
                make.top.equalTo(descriptionLabel.snp.bottom).offset(buttonVerticalSpacing)
                make.bottom.equalToSuperview().offset(-buttonVerticalSpacing)
            }
            
            rightButton.snp.remakeConstraints { make in
                make.width.height.equalTo(0)
            }
        } else {
            leftButton.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(buttonOffset)
                make.width.equalTo(self.snp.width).multipliedBy(0.5).offset(-buttonOffset-buttonDistance)
                make.height.equalTo(buttonHeight)
                make.top.equalTo(descriptionLabel.snp.bottom).offset(buttonVerticalSpacing)
                make.bottom.equalToSuperview().offset(-buttonVerticalSpacing)
            }
            
            rightButton.snp.remakeConstraints { make in
                make.width.equalTo(self.snp.width).multipliedBy(0.5).offset(-buttonOffset-buttonDistance)
                make.trailing.equalToSuperview().offset(-buttonOffset)
                make.height.equalTo(buttonHeight)
                make.top.equalTo(descriptionLabel.snp.bottom).offset(buttonVerticalSpacing)
                make.bottom.equalToSuperview().offset(-buttonVerticalSpacing)
            }
        }
    }
}
