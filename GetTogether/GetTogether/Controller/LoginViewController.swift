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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    func signUpAction() {
        let signUpViewController = SignUpViewController()
        let navigattionVC = UINavigationController(rootViewController: signUpViewController)
        navigattionVC.modalPresentationStyle = .fullScreen
        present(navigattionVC, animated: true)
        
        
    }
    
    
}
