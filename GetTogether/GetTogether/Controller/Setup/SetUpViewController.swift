//
//  SetUpViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class SetUpViewController: UIViewController {
    
    private let setupView = SetupView()
    private var model = setupModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        view.addSubview(setupView)
        
        setupView.delegate = self
        
        
        setupConstraint()
    }

    private func setupConstraint() {
        setupView.layout.top().bottom().leading().trailing()
    }
    

}


extension SetUpViewController: SetupViewDelegate {
    func logoutAction() {
        
        guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        let loginVC = LoginViewController()
        delegate.window?.rootViewController = loginVC
        UserDefaults.standard.set(nil, forKey: "id")
    }
    
    
}
