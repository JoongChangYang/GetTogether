//
//  AddFriendView.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class AddFriendView: UIView {
    
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "addFriendViewCell")
    }
    
    private func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
    }

}
