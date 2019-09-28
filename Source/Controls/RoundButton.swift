//
//  RoundButton.swift
//  Template
//
//  Created by Levente Vig on 2019. 09. 28..
//  Copyright © 2019. levivig. All rights reserved.
//

import UIKit

public protocol RoundButtonBindable {
    var title: String { get }
    var action: () -> Void { get }
}

public class RoundButtonAction: RoundButtonBindable {
    
    private var _title: String
    private var _action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        _title = title
        _action = action
    }
    
    public var title: String {
        return _title
    }
    
    public var action: () -> Void {
        return _action
    }    
}

class RoundButton: UIButton {
    
    // MARK: - Private properties -
    
    private var action: (() -> Void)?
    
    // MARK: - Initialize -
    
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
        backgroundColor = .blue
        titleLabel?.textColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 18)
    }
    
    deinit {
        action = nil
        removeTarget(self, action: #selector(didTap), for: .allEvents)
    }
    
    // MARK: - Action -
    
    @objc private func didTap() {
        action?()
    }
    
    // MARK: - Bind -
    
    func bind(model: RoundButtonBindable) {
        setTitle(model.title, for: .normal)
        action = model.action
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    // MARK: - Layout -
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
    }
    
}
