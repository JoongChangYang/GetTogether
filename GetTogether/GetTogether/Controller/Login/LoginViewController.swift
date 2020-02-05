//
//  LoginViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/02.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private let api = Api(apiProtocol: .http, apiUrl: .logIn, port: 80)
    private var model = LoginModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addNotification()
    }
    
    //노티피케이션 셋팅
    private func addNotification() {
        let loginNotificationName = model.makeNotificationKey(notificationName: .login)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(responseOfLogin(_:)),
            name: NSNotification.Name(loginNotificationName),
            object: nil)
    }
    
    // 로그인 노티 액션
    @objc func responseOfLogin(_ notification: Notification) {
        print(#function)
        let loginNotificationName = model.makeNotificationKey(notificationName: .login)
        guard let data = notification.userInfo?[loginNotificationName] as? [String: Any] else { return }
        guard
            let optionalResult = data["result"] as? String?,
            let stringResult = optionalResult,
            let result = Bool(stringResult),
            let optionalID = data["id"] as? String?,
            let id = optionalID
        else { return }
        
        if result {
            successLogin(id: id)
        }else {
            displayAlert(title: "알림", message: "회원정보를 확인하세요")
            
        }
        
    }
    
    //로그인 성공 이벤트
    private func successLogin(id: String) {

        let customTabBarVC = CustomTabBarController()
        guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = customTabBarVC
        UserDefaults.standard.set(id, forKey: "id")
        
    }
    
    //alert창 띄우기
    private func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    
    //뷰 셋팅
    private func setupUI() {
        
        view.addSubview(loginView)
        loginView.delegate = self
        loginView.layout.top().leading().trailing().bottom()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        loginView.endEditing(true)
    }

}

extension LoginViewController: LoginViewDelegate {
    
    //로그인 버튼 클릭시 뷰 컨트롤러의 처리
    func loginAction(id: String, pw: String) {
        let notificationName = model.makeNotificationKey(notificationName: .login)
        api.request(method: .post, notificationName: notificationName, data: ["id": id, "pw": pw])
    }
    
    func signUpAction() {
        let signUpViewController = SignUpViewController()
        let navigattionVC = UINavigationController(rootViewController: signUpViewController)
        navigattionVC.modalPresentationStyle = .fullScreen
        present(navigattionVC, animated: true)
        
        
    }
    
    
    
}
