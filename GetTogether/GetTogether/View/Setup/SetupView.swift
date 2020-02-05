//
//  SetupView.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

protocol SetupViewDelegate: class {
    func logoutAction()
}

class SetupView: UIView {
    
    let logoutButton = UIButton(type: .system)
    weak var delegate: SetupViewDelegate?
    
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubViews([logoutButton])
        
        logoutButton.setTitle("로그아웃", for: .normal)
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        
        setupConstraint()
        
    }
    
    private func setupConstraint() {
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
    }
    
    @objc func didTapLogoutButton() {
        delegate?.logoutAction()
    }
    
    
}
