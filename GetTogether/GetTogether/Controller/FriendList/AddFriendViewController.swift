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
    let addFriendView = AddFriendView()

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
        let searchBar = UISearchController()
        searchBar.searchBar.delegate = self
        navigationItem.searchController = searchBar
        navigationItem.title = "친구 추가"
    }
    
    private func addNotificationObserver() {
        let searchKey = model.makeNotificationName(notificationName: .searchFriend)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(searchFriend(_:)),
            name: NSNotification.Name(rawValue: searchKey),
            object: nil)
    }
    
    @objc func searchFriend(_ notification: Notification) {
        let notificationName = model.makeNotificationName(notificationName: .searchFriend)
        
        guard let data = notification.userInfo?[notificationName] as? [String: Any] else { return }
        guard let jsonData = data["data"] as? [[String: String]] else { return }
        for userInfo in jsonData {
            model.searchResult.append(userInfo)
        }
        model.searchResult.sort(by: {
            $0["id"]! > $1["id"]!
        })
        addFriendView.tableView.reloadData()
        
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
    
}

extension AddFriendViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = model.searchResult[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "addFriendViewCell") {
            cell.textLabel?.text = data["id"]
            cell.detailTextLabel?.text = data["nickName"]
            return cell
        }else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "addFriendViewCell")
            cell.textLabel?.text = data["id"]
            cell.detailTextLabel?.text = data["nickName"]
            return cell
        }
    }
    
    
}
