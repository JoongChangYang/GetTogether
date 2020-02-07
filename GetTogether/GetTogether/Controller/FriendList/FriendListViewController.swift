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
    private let model = FriendListModel()
    private lazy var getFrienListKey = model.makeNotificationKey(notificationName: .getFriendList)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupUI()
        addObservers()
        friendListView.tableView.dataSource = self
        friendListView.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FriendList.shared.requestOfGetFriendList(notificationName: getFrienListKey)
    }
    
    @objc func getFriendList(_ notification: Notification) {
        
        guard let data = notification.userInfo?[getFrienListKey] as? [String: Any] else { return }
        guard let json = data["result"] as? [[String: String]] else { return }
        var tempUserList: [User] = []
        for userData in json {
            guard
                let id = userData["id"],
                let nickName = userData["nickName"],
                let address = userData["address"],
                let coordinateJson = address.data(using: .utf8),
                let coordinate = try? JSONDecoder().decode(Coordinate.self, from: coordinateJson)
                else { continue }
            let user = User(id: id, nickName: nickName, address: coordinate)
            
            tempUserList.append(user)
        }
        FriendList.shared.list = tempUserList.sorted(by: { $0.id < $1.id })
        friendListView.tableView.reloadData()
        
    }
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getFriendList(_:)),
            name: NSNotification.Name(getFrienListKey),
            object: nil)
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


extension FriendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FriendList.shared.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = FriendList.shared.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListCell", for: indexPath) as! FriendListCell
        cell.configure(id: data.id, nickName: data.nickName, image: nil)
        return cell
    }
    
    
}

extension FriendListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            alert(indexPath: indexPath)
        }
    }
    
    func alert(indexPath: IndexPath) {
        let controller = UIAlertController(title: "경고", message: "친구 데이터를 정말 삭제할까요?\n삭제하면 친구목록에서 사라집니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "삭제", style: .destructive) { (_) in
            FriendList.shared.list.remove(at: indexPath.row)
            self.friendListView.tableView.deleteRows(at: [indexPath], with: .fade)
//            self.friendListView.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        controller.addAction(ok)
        controller.addAction(cancel)
        present(controller, animated: true)
    }
}
