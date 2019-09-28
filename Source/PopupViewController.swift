//
//  PopupViewController.swift
//  Template
//
//  Created by Levente Vig on 2019. 09. 28..
//  Copyright © 2019. levivig. All rights reserved.
//

import UIKit

public class PopupViewController: UIViewController {
    
    private var popup: BasePopup!
    private var backgroundView: UIView!
    
    // swiftlint:disable function_default_parameter_at_end
    public init(title: String,
         subtitle: String? = nil,
         descriptionText: String,
         leftButtonModel: RoundButtonBindable,
         rightButtonModel: RoundButtonBindable? = nil,
         image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        initWithImage(title: title,
                      subtitle: subtitle,
                      descriptionText: descriptionText,
                      leftButtonModel: leftButtonModel,
                      rightButtonModel: rightButtonModel,
                      image: image)
    }
    
    public init(title: String,
         subtitle: String? = nil,
         descriptionText: String,
         leftButtonModel: RoundButtonBindable,
         rightButtonModel: RoundButtonBindable? = nil) {
        super.init(nibName: nil, bundle: nil)
        initialize(title: title,
                   subtitle: subtitle,
                   descriptionText: descriptionText,
                   leftButtonModel: leftButtonModel,
                   rightButtonModel: rightButtonModel)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initWithImage(title: String,
                               subtitle: String?,
                               descriptionText: String,
                               leftButtonModel: RoundButtonBindable,
                               rightButtonModel: RoundButtonBindable? = nil,
                               image: UIImage? = nil) {
        view.backgroundColor = .clear
        initBackground()
        initPopupWithImage(title: title,
                           subtitle: subtitle,
                           descriptionText: descriptionText,
                           leftButtonModel: leftButtonModel,
                           rightButtonModel: rightButtonModel,
                           image: image)
        
    }
    
    private func initPopupWithImage(title: String,
                                    subtitle: String?,
                                    descriptionText: String,
                                    leftButtonModel: RoundButtonBindable,
                                    rightButtonModel: RoundButtonBindable? = nil,
                                    image: UIImage? = nil) {
        popup = ImagePopup(title: title,
                           subtitle: subtitle,
                           descriptionText: descriptionText,
                           leftButtonModel: leftButtonModel,
                           rightButtonModel: rightButtonModel,
                           image: image)
        
        backgroundView.addSubview(popup)
        popup.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.center.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(44)
            make.bottom.lessThanOrEqualToSuperview().offset(-44)
        }
    }
    
    private func initialize(title: String? = nil,
                            subtitle: String? = nil,
                            descriptionText: String? = nil,
                            leftButtonModel: RoundButtonBindable? = nil,
                            rightButtonModel: RoundButtonBindable? = nil) {
        view.backgroundColor = .clear
        
        initBackground()
        initPopup(title: title,
                  subtitle: subtitle,
                  descriptionText: descriptionText,
                  leftButtonModel: leftButtonModel,
                  rightButtonModel: rightButtonModel)
    }
    
    private func initBackground() {

        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.27)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tap.delegate = self
        backgroundView.addGestureRecognizer(tap)
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func initPopup(title: String?,
                           subtitle: String?,
                           descriptionText: String?,
                           leftButtonModel: RoundButtonBindable?,
                           rightButtonModel: RoundButtonBindable? = nil) {
        guard let title = title, let leftButtonModel = leftButtonModel, let descriptionText = descriptionText  else { return }
        popup = Popup(title: title, subtitle: subtitle, descriptionText: descriptionText, leftButtonModel: leftButtonModel, rightButtonModel: rightButtonModel)
        
        backgroundView.addSubview(popup)
        popup.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Action -
    
    @objc private func tapped() {
        hidePopup()
    }
    
    public func hidePopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0.0
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
}

extension PopupViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: popup) ?? false {
            return false
        }
        return true
    }
}
