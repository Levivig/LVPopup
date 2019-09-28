//
//  ImagePopup.swift
//  Template
//
//  Created by Levente Vig on 2019. 09. 28..
//  Copyright © 2019. levivig. All rights reserved.
//

import SnapKit
import SwifterSwift
import UIKit

class ImagePopup: BasePopup {
    
    // MARK: - Private properties -
    
    private var scrollView: UIScrollView!
    
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var imageView: UIImageView!
    private var slider: UISlider!
    
    private var leftButton: RoundButton!
    private var rightButton: RoundButton!
    
    private var imageHeight: CGFloat = 100
    
    private var buttonHeight: CGFloat = 44
    private var buttonOffset: CGFloat = 16
    private var buttonVerticalSpacing: CGFloat = 20
    private var buttonDistance: CGFloat = 8
    
    private var minTopOffset: CGFloat = 44
    private var minBottomOffset: CGFloat = 44
    
    // MARK: - Init -
    
    // swiftlint:disable function_default_parameter_at_end
    init(title: String,
         subtitle: String? = nil,
         descriptionText: String,
         leftButtonModel: RoundButtonBindable,
         rightButtonModel: RoundButtonBindable? = nil,
         image: UIImage?) {
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
        imageView.image = image
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
        
        initScrollView()
        initTitleLabel()
        initSubtitleLabel()
        initDescriptionLabel()
        initImageView()
        initSlider()
        initLeftButton()
        initRightButton()
    }
    
    private func initScrollView() {
        scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        
        addSubview(scrollView)
        setScrollView(height: 100)
    }
    
    private func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor(hex: 0x707070)
        titleLabel.numberOfLines = 0
        
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func initSubtitleLabel() {
        subtitleLabel = UILabel()
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textColor = UIColor(hex: 0x707070)
        subtitleLabel.numberOfLines = 0
        
        scrollView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    private func initDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = UIColor(hex: 0x707070)
        descriptionLabel.numberOfLines = 0
        
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(12)
        }
    }
    
    private func initImageView() {
        imageView = UIImageView()
        
        scrollView.addSubview(imageView)
        setImage(height: imageHeight)
    }
    
    private func initSlider() {
        slider = UISlider()
        slider.addTarget(self, action: #selector(sliderDidSlide(_:)), for: .valueChanged)
        slider.minimumValue = 0
        slider.maximumValue = 1000
        slider.value = 100
        
        scrollView.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func initLeftButton() {
        leftButton = RoundButton(frame: .zero)
        
        addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(buttonOffset)
            make.width.equalTo(self.snp.width).multipliedBy(0.5).offset(-buttonOffset-buttonDistance)
            make.height.equalTo(buttonHeight)
            make.top.equalTo(scrollView.snp.bottom).offset(buttonVerticalSpacing)
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
            make.top.equalTo(scrollView.snp.bottom).offset(buttonVerticalSpacing)
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
                make.top.equalTo(scrollView.snp.bottom).offset(buttonVerticalSpacing)
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
                make.top.equalTo(scrollView.snp.bottom).offset(buttonVerticalSpacing)
                make.bottom.equalToSuperview().offset(-buttonVerticalSpacing)
            }
            
            rightButton.snp.remakeConstraints { make in
                make.width.equalTo(self.snp.width).multipliedBy(0.5).offset(-buttonOffset-buttonDistance)
                make.trailing.equalToSuperview().offset(-buttonOffset)
                make.height.equalTo(buttonHeight)
                make.top.equalTo(scrollView.snp.bottom).offset(buttonVerticalSpacing)
                make.bottom.equalToSuperview().offset(-buttonVerticalSpacing)
            }
        }
    }
    
    private func setImage(height: CGFloat = 100) {
        imageView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(height)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
        }
        imageView.setNeedsUpdateConstraints()
        imageView.layoutIfNeeded()
    }
    
    private func setScrollView(height: CGFloat) {
        scrollView.snp.remakeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.greaterThanOrEqualTo(height)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadius = 8
        
        let size = CGSize(width: self.width, height: slider.y + slider.height)
        scrollView.contentSize = size
        
        let maxHeight = (UIApplication.shared.delegate?.window??.height ?? 0) - (minTopOffset + minBottomOffset)
        
        if size.height > maxHeight {
            setScrollView(height: maxHeight)
        } else {
            setScrollView(height: size.height)
        }
    }
    
    // MARK: - Action -
    
    @objc private func sliderDidSlide(_ sender: UISlider) {
        setImage(height: CGFloat(sender.value))
        setNeedsLayout()
        layoutIfNeeded()
    }
}
