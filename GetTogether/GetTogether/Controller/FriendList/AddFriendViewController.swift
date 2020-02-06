//
//  AddFriendViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {
    
    private let api = Api(apiProtocol: .http, apiUrl: .addFriend, port: 80)
    private var model = addFriendModel()
    private let addFriendView = AddFriendView()
    private let searchBar = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationConstroller()
        setupUI()
        addNotificationObserver()
    }
    
    private func setupUI() {
        view.addSubview(addFriendView)
        addFriendView.tableView.delegate = self
        addFriendView.tableView.dataSource = self
        
        
        setupConstraint()
        
    }
    
    private func setupConstraint() {
        addFriendView.layout.top().leading().trailing().bottom()
    }
    
    private func setupNavigationConstroller() {
        
        searchBar.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchBar
        navigationItem.title = "친구 추가"
    }
    
    
    private func addNotificationObserver() {
        // 친구 검색 옵저버
        let searchKey = model.makeNotificationName(notificationName: .searchFriend)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(searchFriend(_:)),
            name: NSNotification.Name(rawValue: searchKey),
            object: nil)
        
        // 친구 추가 옵저버
        let addKey = model.makeNotificationName(notificationName: .addFriend)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addFriend(_:)),
            name: NSNotification.Name(addKey),
            object: nil)
    }
    
    @objc func addFriend(_ notification: Notification) {
        let notificationName = model.makeNotificationName(notificationName: .addFriend)
        guard let data = notification.userInfo?[notificationName] as? [String: String] else { return }
        guard let stringResult = data["result"], let result = Bool(stringResult) else { return }
        if result {
            navigationController?.popViewController(animated: true)
        }else {
            
        }
    }
    
    @objc func searchFriend(_ notification: Notification) {
        let notificationName = model.makeNotificationName(notificationName: .searchFriend)
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
        guard let data = notification.userInfo?[notificationName] as? [String: Any] else { return }
        guard let jsonData = data["data"] as? [[String: String]] else { return }
        model.searchResult.removeAll()
        
        for userInfo in jsonData {
            guard let friendID = userInfo["id"] else { return }
            guard id != friendID else { continue }
            guard !FriendList.shared.list.contains(where: {
                $0.id == userInfo["id"]
            }) else { continue }
           
            
            model.searchResult.append(userInfo)
        }
        model.searchResult.sort(by: {
            $0["id"]! > $1["id"]!
        })
        addFriendView.tableView.reloadData()
        
    }
    
    private func selectedFriendAlert(friendID: String, friendNickname: String) {
        let alertController = UIAlertController(
            title: "등록 하시겠습니까?",
            message: "아이디 : \(friendID)\n닉네임 : \(friendNickname)",
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
            
            let notificationName = self.model.makeNotificationName(notificationName: .addFriend)
            guard let id = UserDefaults.standard.string(forKey: "id") else { return }
            let data = ["id": id, "friend": friendID]
            self.api.request(method: .post, notificationName: notificationName, data: data)
            
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }

    

}


extension AddFriendViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        api.request(
            method: .get,
            notificationName: model.makeNotificationName(notificationName: .searchFriend),
            data: ["id": query])
    }
}


extension AddFriendViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = model.searchResult[indexPath.row]
        guard let id = data["id"], let nickName = data["nickName"] else { return }
        selectedFriendAlert(friendID: id, friendNickname: nickName)
    }
    
}

extension AddFriendViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.searchResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let data = model.searchResult[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListCell", for: indexPath) as! FriendListCell
        cell.configure(id: data["id"], nickName: data["nickName"], image: nil)
        return cell
    }


}
