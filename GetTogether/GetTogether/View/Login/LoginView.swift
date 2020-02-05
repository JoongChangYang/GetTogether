//
//  LoginView.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/02.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: class {
    func signUpAction()
    
    func loginAction(id: String, pw: String)
}

class LoginView: UIView {
    
    private let idTextField = UITextField()
    private let pwTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let signUpButton = UIButton(type: .system)
    
    
    weak var delegate: LoginViewDelegate?

   override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 뷰들의 기본 셋팅
    private func setupUI() {
        backgroundColor = .white
        addSubViews([ idTextField, pwTextField, loginButton, signUpButton])
        
        idTextField.placeholder = "아이디"
        idTextField.borderStyle = .roundedRect
        
        pwTextField.placeholder = "비밀번호"
        pwTextField.borderStyle = .roundedRect
        pwTextField.isSecureTextEntry = true
        pwTextField.textContentType = .password
        
        loginButton.backgroundColor = ThemeColor.basic
        loginButton.setTitle("로그인", for: .normal)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 4
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton(_:)), for: .touchUpInside)
        
        setupConstraint()
    }
    
    
    // 뷰들의 오토레이아웃
    private func setupConstraint() {
        
        
        let margin: CGFloat = 8
        let height: CGFloat = 56
        
        signUpButton.layout.centerX().centerY()
        
        loginButton.layout.leading(constant: margin * 3).trailing(constant: -(margin * 3)).bottom(equalTo: signUpButton.topAnchor, constant: -margin)
        loginButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        pwTextField.layout.leading(constant: margin * 3).trailing(constant: -(margin * 3)).bottom(equalTo: loginButton.topAnchor, constant:  -margin)
        pwTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        idTextField.layout.leading(constant: margin * 3).trailing(constant: -(margin * 3)).bottom(equalTo: pwTextField.topAnchor, constant: -margin)
        idTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
    
    //로그인 버튼 클릭 이벤트
    @objc private func didTapLoginButton() {
        guard let id = idTextField.text, let pw = pwTextField.text else { return }
        delegate?.loginAction(id: id, pw: pw)
    }
    
    
    //회원가입 버튼 클릭 이벤트
    @objc private func didTapSignUpButton(_ sender: UIButton) {
        delegate?.signUpAction()
    }
    
}
