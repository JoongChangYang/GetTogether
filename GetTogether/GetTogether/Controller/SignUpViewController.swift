//
//  SignUpViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/02.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    private var sginUpViewBottomConstraint: NSLayoutConstraint?
    private var api = Api(apiProtocol: .http, apiUrl: .signUp, port: 80)
    private let className = "SignUpViewController"
    private var coordinate: Coordinate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addNotification()
        
    }
    
    private func setupUI() {
        view.addSubview(signUpView)
        let backButton = UIBarButtonItem(title: "Login", style: .done, target: self, action: #selector(didTapBackButton(_:)))
        navigationItem.leftBarButtonItem = backButton
        
        signUpView.delegate = self
        
        
        signUpView.layout.leading().trailing().top()
        
        sginUpViewBottomConstraint = signUpView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        sginUpViewBottomConstraint?.isActive = true
        
    }
    
    private func displayAlert(title: String, message: String, action: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "확인",
            style: .default,
            handler: { _ in
               action?()
        })
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
        
        
    }
    
    private func addNotification() {
        
        
        NotificationCenter.default.addObserver( // 아이디 체크 옵저버
            self,
            selector: #selector(idCheckNotification(_:)),
            name: NSNotification.Name(className + NotificationName.idCheck.rawValue),
            object: nil)
        
        NotificationCenter.default.addObserver(// 회원 가입 옵저버
            self,
            selector: #selector(signUpResponse(_:)),
            name: NSNotification.Name(className + NotificationName.signUp.rawValue),
            object: nil)
    }
    
    @objc func idCheckNotification(_ notification: Notification) {
        print(#function)
        let notificationName = NotificationName.idCheck.rawValue
        guard let jsonData = notification.userInfo?[notificationName] as? String else { return }
        guard let data = jsonData.data(using: .utf8) else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else { return }
        guard let stringResult = json["result"] else { return }
        guard let result = Bool(stringResult) else { return }
        if result {
            displayAlert(title: "알림", message: "사용가능한 아이디 입니다.")
        }else {
            displayAlert(title: "알림", message: "사용중인 아이디 입니다.")
        }
        
        signUpView.idCheck = result
        
    }
    
    @objc func signUpResponse(_ notification: Notification) {
        let notificationName = NotificationName.signUp.rawValue
        guard let jsonData = notification.userInfo?[notificationName] as? String else { return }
        guard let data = jsonData.data(using: .utf8) else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            else { return }
        guard let stringResult = json["result"] else { return }
        guard let result = Bool(stringResult) else { return }
        if result {
            displayAlert(title: "알림",
                         message: "회원가입이 완료 되었습니다.",
                         action: {
                            self.dismiss(animated: true, completion: nil)
            })
            
        }else {
            displayAlert(title: "알림", message: "다시 시도해 주세요.")
        }
        
        
    }
    
    
    @objc func didTapBackButton(_ sender: UIBarButtonItem) {
            self.dismiss(animated: true)
        }
    


}


extension SignUpViewController: signUpViewDelegate {
    func SignUpAction(user: User) {
        
        guard let pw = user.pw else {
            alertAction(title: "알림", message: "비밀번호를 확인해 주세요.")
            return
        }
        let data = ["id": user.id, "nickName": user.nickName, "pw": pw, "address": user.address]
        
        api.request(
            method: .post,
            notificationName: className + NotificationName.signUp.rawValue,
            data: data
        )
    }
    
    func alertAction(title: String, message: String) {
        displayAlert(title: title, message: message)
    }
    
    func IDCheckAction(id: String) {
        if  id.isEmpty {
            displayAlert(title: "알림", message: "아이디를 입력해 주세요")
            return
        }
        api.request(method: .get, notificationName: className + NotificationName.idCheck.rawValue, data: ["id": id])
    }
    
    func presentSerchMapViewController() {
        let mapSearchVC = MapSearchViewController(queryType: .address)
        mapSearchVC.delegate = self
        navigationController?.pushViewController(mapSearchVC, animated: true)
    }
    
}


extension SignUpViewController: MapSearchViewControllerDelegate {
    func didTapOkButton(coordinate: Coordinate, addressName: String) {
        self.coordinate = coordinate
        
    }
    
    
}
