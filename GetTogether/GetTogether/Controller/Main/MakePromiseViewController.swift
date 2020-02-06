//
//  MakePromiseViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/07.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class MakePromiseViewController: UIViewController {
    
    private let makePromiseView = MakePromiseView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    
    private func setupUI() {
        view.addSubview(makePromiseView)
        makePromiseView.tableView.dataSource = self
        makePromiseView.tableView.delegate = self
        setupConstraint()
    }
    
    private func setupConstraint() {
        makePromiseView.layout.top().bottom().leading().trailing()
    }
    
    

}


extension MakePromiseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FriendList.shared.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MakePromise", for: indexPath) as! FriendListCell
        let data = FriendList.shared.list[indexPath.row]
        cell.configure(id: data.id, nickName: data.nickName, image: nil)
        return cell
    }
    
    
}

extension MakePromiseViewController: UITableViewDelegate {
    
}


