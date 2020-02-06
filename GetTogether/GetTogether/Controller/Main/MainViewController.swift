//
//  MainViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: MapSearchViewController {
    
    private let notificationName = "MainViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FriendList.shared.requestOfGetFriendList(notificationName: notificationName)
    }

    @objc func getFriendList(_ notification: Notification) {
        
        guard let data = notification.userInfo?[notificationName] as? [String: Any] else { return }
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
        
    }
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getFriendList(_:)),
            name: NSNotification.Name(notificationName),
            object: nil)
    }

}

//MapDelgate
//extension MainViewController {
//    override func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//
//    }
//}
