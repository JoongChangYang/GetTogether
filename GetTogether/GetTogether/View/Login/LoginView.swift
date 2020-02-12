////
////  LoginView.swift
////  GetTogether
////
////  Created by 양중창 on 2020/02/02.
////  Copyright © 2020 didwndckd. All rights reserved.
////
//
//import UIKit
//
//protocol LoginViewDelegate: class {
//    func signUpAction()
//
//    func loginAction(id: String, pw: String)
//}
//
//class LoginView: UIView {
//
//    private let idTextField = UITextField()
//    private let pwTextField = UITextField()
//    private let loginButton = UIButton(type: .system)
//    private let signUpButton = UIButton(type: .system)
//    private let logoImageView = UIImageView()
//    private let stackView = UIStackView()
//    private let title = UILabel()
//
//    weak var delegate: LoginViewDelegate?
//
//   override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    // 뷰들의 기본 셋팅
//    private func setupUI() {
//        backgroundColor = .white
//        addSubViews([ idTextField, pwTextField, loginButton, signUpButton, logoImageView, stackView, title])
//
//        idTextField.placeholder = "아이디"
//        idTextField.borderStyle = .roundedRect
//
//        pwTextField.placeholder = "비밀번호"
//        pwTextField.borderStyle = .roundedRect
//        pwTextField.isSecureTextEntry = true
//        pwTextField.textContentType = .password
//
//        loginButton.backgroundColor = ThemeColor.basic
//        loginButton.setTitle("로그인", for: .normal)
//        loginButton.tintColor = .white
//        loginButton.layer.cornerRadius = 4
//        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
//        loginButton.shadow()
//
//        signUpButton.setTitle("회원가입", for: .normal)
//        signUpButton.addTarget(self, action: #selector(didTapSignUpButton(_:)), for: .touchUpInside)
//
//        logoImageView.image = UIImage(named: "Logo")
//        logoImageView.contentMode = .scaleAspectFit
//
//        stackView.backgroundColor = .red
//
//        title.text = "친구들의 중간위치는?"
//        title.textColor = #colorLiteral(red: 0.2039215686, green: 0.4745098039, blue: 0.8784313725, alpha: 1)
//        title.font = UIFont.boldSystemFont(ofSize: 24)
//
//        setupConstraint()
//    }
//
//
//    // 뷰들의 오토레이아웃
//    private func setupConstraint() {
//
//        let margin: CGFloat = 8
//        let height: CGFloat = 56
//        let guide = self.safeAreaLayoutGuide
//
//        stackView.layout.leading().trailing().top(equalTo: guide.topAnchor).bottom(equalTo: idTextField.topAnchor)
//
//        logoImageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            logoImageView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.32),
//            logoImageView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.16)
//        ])
//
//        logoImageView.layout.centerX().centerY(equalTo: stackView.centerYAnchor, constant: -margin * 2)
//
//        title.layout.centerX().top(equalTo: logoImageView.bottomAnchor, constant: margin * 2)
//
//        signUpButton.layout.centerX().centerY(equalTo: guide.centerYAnchor, constant: 120)
//
//        loginButton.layout.leading(constant: margin * 3).trailing(constant: -(margin * 3)).bottom(equalTo: signUpButton.topAnchor, constant: -margin)
//        loginButton.heightAnchor.constraint(equalToConstant: height).isActive = true
//
//        pwTextField.layout.leading(constant: margin * 3).trailing(constant: -(margin * 3)).bottom(equalTo: loginButton.topAnchor, constant:  -margin * 3)
//        pwTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
//
//        idTextField.layout.leading(constant: margin * 3).trailing(constant: -(margin * 3)).bottom(equalTo: pwTextField.topAnchor, constant: -margin)
//        idTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
//
//    }
//
//    //로그인 버튼 클릭 이벤트
//    @objc private func didTapLoginButton() {
//        guard let id = idTextField.text, let pw = pwTextField.text else { return }
//        delegate?.loginAction(id: id, pw: pw)
//    }
//
//
//    //회원가입 버튼 클릭 이벤트
//    @objc private func didTapSignUpButton(_ sender: UIButton) {
//        delegate?.signUpAction()
//    }
//
//}


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
    private let logoImageView = UIImageView()
    private let stackView = UIStackView()
    private let title = UILabel()
    
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
        addSubViews([ idTextField, pwTextField, loginButton, signUpButton, logoImageView, stackView, title])
        
        idTextField.placeholder = "아이디"
        idTextField.borderStyle = .roundedRect
        
        pwTextField.placeholder = "비밀번호"
        pwTextField.borderStyle = .roundedRect
        pwTextField.isSecureTextEntry = true
        pwTextField.textContentType = .password
        
        loginButton.backgroundColor = ThemeColor.basic
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 4
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginButton.shadow()
        
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton(_:)), for: .touchUpInside)
        
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.contentMode = .scaleAspectFit
        
        stackView.backgroundColor = .red
        
        title.text = "친구들의 중간위치는?"
        title.textColor = #colorLiteral(red: 0.2039215686, green: 0.4745098039, blue: 0.8784313725, alpha: 1)
        title.font = UIFont.boldSystemFont(ofSize: 24)
        
        setupConstraint()
    }
    
    
    // 뷰들의 오토레이아웃
    private func setupConstraint() {
        
        let margin: CGFloat = 8
        let height: CGFloat = 56
        let guide = self.safeAreaLayoutGuide
        
        stackView.layout.leading().trailing().top(equalTo: guide.topAnchor).bottom(equalTo: idTextField.topAnchor)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.32),
            logoImageView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.16)
        ])
        
        logoImageView.layout.centerX().centerY(equalTo: stackView.centerYAnchor, constant: -margin * 2)
        
        title.layout.centerX().top(equalTo: logoImageView.bottomAnchor, constant: margin * 2)
        
        signUpButton.layout.centerX().centerY(equalTo: guide.centerYAnchor, constant: 120)
        
        loginButton.layout.leading(constant: margin * 3).trailing(constant: -(margin * 3)).bottom(equalTo: signUpButton.topAnchor, constant: -(margin * 2))
        loginButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        pwTextField.layout.leading(constant: margin * 3).trailing(constant: -(margin * 3)).bottom(equalTo: loginButton.topAnchor, constant:  -margin * 3)
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
