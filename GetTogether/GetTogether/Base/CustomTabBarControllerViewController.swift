//
//  CustomTaBarControllerViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let mainVC = MainViewController()
        mainVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "location"),
            tag: 0)
        let friendListVC = UINavigationController(rootViewController: FriendListViewController())
        friendListVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "person.3"), tag: 1)
        let getTogetherListVC = GetTogetherListViewController()
        getTogetherListVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "list.bullet"),
            tag: 2)
        let setupVC = SetUpViewController()
        setupVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "command"),
            tag: 3)
        viewControllers = [mainVC, friendListVC, getTogetherListVC, setupVC]
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    

    

}
