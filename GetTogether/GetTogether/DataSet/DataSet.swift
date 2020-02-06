//
//  DataSet.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/03.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import Foundation
import UIKit


struct Coordinate: Codable {
    
    let latitude: Double // y
    let longitude: Double //x
}


struct Promise: Codable {
    let date: Date
    let members: String
    let placeTitle: String
    let placeLatitude: Double // 위도
    let placeLongitude: Double // 경도
    let comment: String
}

class FriendList {
    static var shared = FriendList()
    var list: [User] = []
    var api = Api(apiProtocol: .http, apiUrl: .getFriendList, port: 80)
    
    
    func requestOfGetFriendList(notificationName: String) {
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
        api.request(method: .get, notificationName: notificationName, data: ["id": id])
    }
    
    
}


struct Place {
    let coordinate: Coordinate
    let placeName: String?
    let roadAddress: String?
    let addressName: String?
    let placeUrl: String?
    
}
