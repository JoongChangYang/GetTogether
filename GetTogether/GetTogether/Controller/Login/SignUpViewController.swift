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
    private let api = Api(apiProtocol: .http, apiUrl: .signUp, port: 80)
    private var model = SignupModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationController()
        addNotification()
        
    }
    
    private func setupUI() {
        view.addSubview(signUpView)
        
        title = "회원가입"
        signUpView.delegate = self
        
        
        signUpView.layout.leading().trailing().top()
        
        sginUpViewBottomConstraint = signUpView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        sginUpViewBottomConstraint?.isActive = true
        
    }
    
    private func setupNavigationController() {
        let backButton = UIBarButtonItem(title: "Login", style: .done, target: self, action: #selector(didTapBackButton(_:)))
        navigationItem.leftBarButtonItem = backButton
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
            name: NSNotification.Name(model.makeNotificationName(notificationName: .idCheck)),
            object: nil)
        
        NotificationCenter.default.addObserver(// 회원 가입 옵저버
            self,
            selector: #selector(signUpResponse(_:)),
            name: NSNotification.Name(model.makeNotificationName(notificationName: .signUp)),
            object: nil)
    }
    
    @objc func idCheckNotification(_ notification: Notification) {
        print(#function)
        let notificationName = model.makeNotificationName(notificationName: .idCheck)
        guard let data = notification.userInfo?[notificationName] as? [String: Any?] else { return }
        guard let stringResult = data["result"] as? String, let result = Bool(stringResult) else { return }
        if result {
            displayAlert(title: "알림", message: "사용가능한 아이디 입니다.")
        }else {
            displayAlert(title: "알림", message: "사용중인 아이디 입니다.")
        }

        signUpView.idCheck = result
        
    }
    
    @objc func signUpResponse(_ notification: Notification) {
//        let notificationName = model.makeNotificationName(notificationName: .signUp)
//        guard let jsonData = notification.userInfo?[notificationName] as? String else { return }
//        guard let data = jsonData.data(using: .utf8) else { return }
//        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
//            else { return }
//        guard let stringResult = json["result"] else { return }
//        guard let result = Bool(stringResult) else { return }
        
        let notificationName = model.makeNotificationName(notificationName: .signUp)
        guard let data = notification.userInfo?[notificationName] as? [String: Any?] else { return }
        guard let stringResult = data["result"] as? String, let result = Bool(stringResult) else { return }
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
    
    func SignUpAction(id: String, nickName: String, pw: String) {
        guard let coordinateData = model.coordinate else {
            displayAlert(title: "알림", message: "주소를 등록 하세요.")
            return
        }
        
        guard
            let coordinate = try? JSONEncoder().encode(coordinateData),
            let address = String(data: coordinate, encoding: .utf8)
            else { return }
        
        let user = User(id: id, nickName: nickName, address: coordinateData, pw: pw, image: nil)
        
        
        api.request(
            method: .post,
            notificationName: model.makeNotificationName(notificationName: .signUp),
            data: ["id": user.id, "nickName": user.nickName, "address": address , "pw": pw]
        )
    }
    
    
    func alertAction(title: String, message: String) {
        displayAlert(title: title, message: message)
    }
    
    // 중복확인 버튼의 액션
    func IDCheckAction(id: String) {
        if  id.isEmpty {
            displayAlert(title: "알림", message: "아이디를 입력해 주세요")
            return
        }
        api.request(method: .get, notificationName: model.makeNotificationName(notificationName: .idCheck), data: ["id": id])
    }
    
    // 주소검색 뷰 띄움
    func presentSerchMapViewController() {
        let mapSearchVC = MapSearchViewController()
        mapSearchVC.delegate = self
        navigationController?.pushViewController(mapSearchVC, animated: true)
    }
    
}


extension SignUpViewController: MapSearchViewControllerDelegate {
    
    // 지도의 핀 눌렀을 때 signUpView의 주소 레이블에 텍스트 표시, model의 coordinate 값 할당
    func didTapOkButton(coordinate: Coordinate, addressName: String) {
        self.model.coordinate = coordinate
        signUpView.setAdressName(addressName: addressName)
    }
    
    
}
