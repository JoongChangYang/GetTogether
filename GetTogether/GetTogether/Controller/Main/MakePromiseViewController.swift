//
//  MakePromiseViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/07.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

enum MakePromiseCase: String {
    case defult
    case center
}



class MakePromiseViewController: UIViewController {
    
    private let makePromiseView = MakePromiseView()
    private var model: MakePromiseModel
    private let makePromiseCase: MakePromiseCase
    
    init(model: MakePromiseModel, makePromiseCase: MakePromiseCase) {
        self.model = model
        self.makePromiseCase = makePromiseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    
    private func setupUI() {
        view.addSubview(makePromiseView)
        makePromiseView.tableView.dataSource = self
        makePromiseView.tableView.delegate = self
        makePromiseView.delegate = self
        setupConstraint()
    }
    
    private func setupConstraint() {
        makePromiseView.layout.top().bottom().leading().trailing()
    }
    
    @objc func addPromise(_ notification: Notification) {
        
        guard let data = notification.userInfo?[model.makeNotificationKey(makePromiseCase)] as? [String: Any] else { return }
        guard let json = data["result"] as? String, let result = Bool(json) else { return }
        if result {
            displayAlert(title: "알림", message: "약속잡기 완료")
        }else {
            displayAlert(title: "알림", message: "다시 시도해주세요")
        }
        
    }
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addPromise(_:)),
            name: NSNotification.Name(model.makeNotificationKey(makePromiseCase)),
            object: nil)
    }
    
    
    private func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(okAction)
        present(alertController, animated: true)
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

extension MakePromiseViewController: MakePromiseViewDelegate {
    
    func makePromise(comment: String, date: Date) {
        
        
        if makePromiseCase == .defult {
            guard let members = makePromiseView.tableView.indexPathsForSelectedRows else { return }
            let friends = FriendList.shared.list
            model.members.removeAll()
            guard
                let id = UserDefaults.standard.string(forKey: "id"),
                let nickName = UserDefaults.standard.string(forKey: "nickName")
                else { return }
            
//            model.members.append(["id": id, "nickName": nickName])
            var idArr: [String] = []
            var nickArr: [String] = []
            idArr.append(id)
            nickArr.append(nickName)
            for index in members {
                let id = friends[index.row].id
                let nickName = friends[index.row].nickName
                idArr.append(id)
                nickArr.append(nickName)
                
//                model.members.append(member)
            }
            model.comment = comment
            model.date = date
            
            
            
            
            guard let rootVC = navigationController?.viewControllers.first as? MapSearchViewController else { return }
            var data: [String: String] = [:]
            
            let latitude = String(model.coordinate.latitude)
            let longitude = String(model.coordinate.longitude)
            
            guard let dateData = try? JSONEncoder().encode(date) else { return }
            guard let jsonDate = try? String(data: dateData, encoding: .utf8) else { return }
            
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyyMMddHHmm"
//            formatter.timeZone = TimeZone.current
//            let returnFormat = formatter.string(from: date)
            
            var ids = idArr.reduce("", { $0 + "/" + $1 })
            ids.removeFirst()
            var nicks = nickArr.reduce("", { $0 + "," + $1 })
            nicks.removeFirst()
            
            data["members"] = nicks
            data ["placeTitle"] = model.placeTitle
            data["comment"] = model.comment ?? " "
            data["date"] = jsonDate
            data["ids"] = ids
            data["addressName"] = model.addressName
            data["latitude"] = latitude
            data["longitude"] = longitude
            
            
            
            rootVC.api.request(
                method: .post,
                notificationName: model.makeNotificationKey(makePromiseCase),
                data: data)
            rootVC.mapSearchView.mapView.selectedAnnotations.removeAll()
            rootVC.placeInfoView.transform = .init(scaleX: 0, y: 0)
            rootVC.placeInfoView.isHidden = true
            navigationController?.popViewController(animated: true)
        }
        
        
        
        
    }
    
    
}

