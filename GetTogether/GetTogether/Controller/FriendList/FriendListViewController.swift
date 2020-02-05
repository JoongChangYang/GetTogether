//
//  FriendListViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class FriendListViewController: UIViewController {
    
    let friendListView = FriendListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupUI()
    }
    
    
    private func setupUI() {
        view.addSubview(friendListView)
        setupConstraint()
        
    }
    
    private func setupConstraint() {
        friendListView.layout.top().bottom().leading().trailing()
    }
    
    
    private func setupNavigationController() {
        navigationItem.title = "친구목록"
        
        let addFriendButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .done,
            target: self,
            action: #selector(didTapAddFriend))
        let searchFriendButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .done,
            target: self,
            action: #selector(didTapSearchFriendButton))
        
        navigationItem.rightBarButtonItem = searchFriendButton
        navigationItem.leftBarButtonItem = addFriendButton
        
    }
    
    @objc func didTapAddFriend() {
        let addFriendVC = AddFriendViewController()
        navigationController?.pushViewController(addFriendVC, animated: true)
    }
    
    @objc func didTapSearchFriendButton() {
        
    }
    

}
