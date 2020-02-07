//
//  SignUpView.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/02.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

protocol signUpViewDelegate: class {
    func IDCheckAction(id: String)
    
    func SignUpAction(id: String, nickName: String, pw: String)
    
    func alertAction(title: String, message: String)
    
    func presentSerchMapViewController()
    
    func searchAction(query: String)
    
}

class SignUpView: UIView {
    
    private var pwSameText = false {
        didSet {
            
            if pwSameText {
                sparkleTextField(textField: pwTextField, bool: true)
                sparkleTextField(textField: pwCheckTextField, bool: true)
            }
        }
    }
    
    var idCheck = false {
        didSet{
            
            if idCheck {
                sparkleTextField(textField: idTextField, bool: true)
            }
        }
    }
    private var idCountCheck = false {
        didSet {
            idCheck = false
        }
    }
    private var nickNameCheck = false
    
    var constraint = NSLayoutConstraint()
    private let idTextField = UITextField()
    private let idCheckButton = UIButton(type: .system)
    
    private let pwTextField = UITextField()
    private let pwCheckTextField = UITextField()
    
    private let nickNameTextField = UITextField()
    
    private let searchAddressButton = UIButton(type: .system)
    
//    private let addressNameLabel = UILabel()
    
    let addressTextField = UITextField()
    
    private let signUpButton = UIButton(type: .system)
    
    private let scrollView = UIScrollView()
    
    let tableView = UITableView()
    
    private var scrollViewConstraint: NSLayoutConstraint?
    
    weak var delegate: signUpViewDelegate?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupNotification()
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print(#function)
        
    }
    
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubViews([idTextField, idCheckButton, nickNameTextField, pwTextField, pwCheckTextField, addressTextField, searchAddressButton, signUpButton, tableView])
        
        
        
        idTextField.placeholder = "아이디(3 ~ 12자)"
        idTextField.borderStyle = .roundedRect
        idTextField.tag = 0
        idTextField.delegate = self
        
        idCheckButton.setTitle("중복 확인", for: .normal)
        idCheckButton.backgroundColor = ThemeColor.basic
        idCheckButton.tintColor = .white
        idCheckButton.layer.cornerRadius = 4
        idCheckButton.addTarget(self, action: #selector(didTapIDCheckButton), for: .touchUpInside)
        idCheckButton.shadow()
        
        nickNameTextField.placeholder = "닉네임(2 ~ 12자)"
        nickNameTextField.borderStyle = .roundedRect
        nickNameTextField.tag = 1
        nickNameTextField.delegate = self
        
        pwTextField.placeholder = "비밀번호(4 ~ 16자)"
        pwTextField.borderStyle = .roundedRect
        pwTextField.delegate = self
        pwTextField.tag = 2
        pwTextField.isSecureTextEntry = true
        pwTextField.textContentType = .password
        
        pwCheckTextField.placeholder = "비밀번호 확인"
        pwCheckTextField.borderStyle = .roundedRect
        pwCheckTextField.delegate = self
        pwCheckTextField.tag = 3
        pwCheckTextField.isSecureTextEntry = true
        pwCheckTextField.textContentType = .password
        
        addressTextField.placeholder = "ex. 서울특별시 강남구 삼성동 159"
        addressTextField.borderStyle = .roundedRect
        addressTextField.tag = 0
        addressTextField.delegate = self
        
        searchAddressButton.setTitle("주소 검색", for: .normal)
        searchAddressButton.backgroundColor = ThemeColor.basic
        searchAddressButton.layer.cornerRadius = 4
        searchAddressButton.tintColor = .white
        searchAddressButton.addTarget(self, action: #selector(didTapSearchAddressButton), for: .touchUpInside)
        searchAddressButton.shadow()
        
//        addressNameLabel.text = "주소를 등록해 주세요."
//        addressNameLabel.textColor = ThemeColor.warning
        
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.4745098039, blue: 0.8784313725, alpha: 1)
        signUpButton.tintColor = .white
        signUpButton.layer.cornerRadius = 4
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        signUpButton.shadow()
        
        setupConstraint()
//        testSetup()
        
    }
    
    private func setupConstraint() {
        
        let marginY: CGFloat = 8
        let marginX: CGFloat = 24
        let height: CGFloat = 56 // 56
    

        scrollView.layout.top().leading().trailing()
        scrollViewConstraint = scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        scrollViewConstraint?.isActive = true

        idTextField.layout
            .top(equalTo: scrollView.topAnchor,constant: marginY * 12)
            .leading(equalTo: scrollView.leadingAnchor, constant: marginX)
        idTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
        idTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.65).isActive = true
        
        idCheckButton.layout
            .top(equalTo: scrollView.topAnchor, constant: marginY * 12)
            .leading(equalTo: idTextField.trailingAnchor, constant: 10)
            .trailing(equalTo: scrollView.trailingAnchor, constant: -marginX)
        idCheckButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        nickNameTextField.layout
            .top(equalTo: idTextField.bottomAnchor, constant: marginY)
            .leading(equalTo: scrollView.leadingAnchor, constant: marginX)
            .trailing(equalTo: scrollView.trailingAnchor, constant: -marginX)
        nickNameTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
        nickNameTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(marginX * 2)).isActive = true
        
        pwTextField.layout
            .top(equalTo: nickNameTextField.bottomAnchor, constant: marginY)
            .leading(equalTo: scrollView.leadingAnchor, constant: marginX)
            .trailing(equalTo: scrollView.trailingAnchor, constant: -marginX)
        pwTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
        pwTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(marginX * 2)).isActive = true
        
        pwCheckTextField.layout
            .top(equalTo: pwTextField.bottomAnchor, constant: marginY)
            .leading(equalTo: scrollView.leadingAnchor, constant: marginX)
            .trailing(equalTo: scrollView.trailingAnchor, constant: -marginX)
        pwCheckTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
        pwCheckTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(marginX * 2)).isActive = true
        
//        addressNameLabel.layout
//        .top(equalTo: pwCheckTextField.bottomAnchor, constant: marginY)
//        .leading(equalTo: scrollView.leadingAnchor, constant: marginX)
//        .trailing(equalTo: scrollView.trailingAnchor, constant: -marginX)
//        addressNameLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
//        addressNameLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(marginX * 2)).isActive = true
        
 
         addressTextField.layout
            .top(equalTo: pwCheckTextField.bottomAnchor, constant: marginY)
             .leading(equalTo: scrollView.leadingAnchor, constant: marginX)
         addressTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
         addressTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.65).isActive = true
 
        searchAddressButton.layout
            .top(equalTo: pwCheckTextField.bottomAnchor, constant: marginY)
            .leading(equalTo: addressTextField.trailingAnchor, constant: 10)
            .trailing(equalTo: scrollView.trailingAnchor, constant: -marginX)
        searchAddressButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        tableView.layout
            .top(equalTo: addressTextField.bottomAnchor, constant: marginY)
            .leading(equalTo: scrollView.leadingAnchor, constant: 10)
            .trailing(equalTo: scrollView.trailingAnchor, constant: -marginX)
        constraint = tableView.bottomAnchor.constraint(equalTo: addressTextField.bottomAnchor)
        constraint.isActive = true
        

        signUpButton.layout
            .top(equalTo: searchAddressButton.bottomAnchor, constant: marginY * 3)
            .leading(equalTo: scrollView.leadingAnchor, constant: marginX)
            .trailing(equalTo: scrollView.trailingAnchor, constant: -marginX)
            .bottom(equalTo: scrollView.bottomAnchor)
        signUpButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(marginX * 2)).isActive = true
        
         
        
        
    }
    
//    func setAdressName(addressName: String) {
//        addressNameLabel.text = addressName
//        addressNameLabel.textColor = ThemeColor.affirmation
//    }
    
    
    @objc func didTapSearchAddressButton() {
        guard let test = addressTextField.text else { return }
        delegate?.searchAction(query: test)
        
    }
    
    
    @objc func didTapIDCheckButton() {
        guard idCountCheck else { return }
        if let id = idTextField.text {
            delegate?.IDCheckAction(id: id)
        }
        
    }
    
    
    // 회원가입 버튼 클릭
    @objc func didTapSignUpButton() {
        guard let id = idTextField.text,
            let pw = pwTextField.text,
            let nickname = nickNameTextField.text
            else {
                delegate?.alertAction(title: "알림", message: "회원정보를 확인하세요")
                return
        }
        guard idCheck && pwSameText && nickNameCheck else {
            delegate?.alertAction(title: "알림", message: "회원정보를 확인하세요")
            return
        }
        
        delegate?.SignUpAction(id: id, nickName: nickname, pw: pw)
    }
    
    
    //노티피게이션 등록
       private func setupNotification() {
           NotificationCenter.default.addObserver(
               self,
               selector: #selector(keyboardWillShow(_:)),
               name: UIResponder.keyboardWillShowNotification,
               object: nil)
           
           NotificationCenter.default.addObserver(
               self,
               selector: #selector(keyBoardWillHide(_:)),
               name: UIResponder.keyboardWillHideNotification,
               object: nil)
           
       }
       
       //키보드 올라오는 상황
       @objc private func keyboardWillShow(_ notification: Notification) {
           
           guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
           guard let animationDurection = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
           
               let keyboardRectangle = keyboardFrame.cgRectValue
               let keyboardHeight = keyboardRectangle.height
               
               
               UIView.animate(withDuration: animationDurection, animations: {
                   self.scrollViewConstraint?.constant = -keyboardHeight
                   self.layoutIfNeeded()
               })
               
           
       }
       // 키보드 내려가는 상황
       @objc private func keyBoardWillHide(_ notification: Notification) {
           guard let animationDurection = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
           UIView.animate(withDuration: animationDurection, animations: {
               self.scrollViewConstraint?.constant = 0
               self.layoutIfNeeded()

           })
           
       }
    
    
    
    
}


extension SignUpView: UITextFieldDelegate {
    
    private func sparkleTextField(textField: UITextField, bool: Bool) {
        if !bool {
            textField.backgroundColor = ThemeColor.warning
            UIView.animate(withDuration: 0.5, animations: {
                textField.backgroundColor = .white
            })
        }else {
            textField.backgroundColor = ThemeColor.affirmation
            UIView.animate(withDuration: 0.5, animations: {
                textField.backgroundColor = .white
            })
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text ?? ""
        let replaceText = (text as NSString).replacingCharacters(in: range, with: string)
//        print(textField.tag)
        
        switch textField.tag {
        case 0 where replaceText.count > 12:
            sparkleTextField(textField: textField, bool: false)
            return false
        case 1 where replaceText.count > 12:
            sparkleTextField(textField: textField, bool: false)
            return false
        case 2 where replaceText.count > 16:
            sparkleTextField(textField: textField, bool: false)
            return false
        case 3 where replaceText.count > 16:
            sparkleTextField(textField: textField, bool: false)
            return false
        default:
            return true
        }
        
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let tag = textField.tag
        
        if tag == 0 {
            
            let idCount = idTextField.text?.count ?? 0
            idCountCheck = idCount > 2 ? true: false
            
        }else if tag == 1 {
            
            let nickNameCount = nickNameTextField.text?.count ?? 0
            nickNameCheck = nickNameCount > 1 ? true: false
            
        }else if tag == 2 || tag == 3 {
            
            guard let pw = pwTextField.text else { return }
            guard let pwCheck = pwCheckTextField.text else { return }
            
            if pw == pwCheck && pw.count > 4 {
                pwSameText = true
            }else {
                pwSameText = false
            }
            
        }
        
        
        
        
        
        
    }
    
    
    
}
