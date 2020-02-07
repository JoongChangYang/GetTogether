//
//  GetTogetherListModel.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/07.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import Foundation

struct GetTogetherListModel {
    var searchResult: [[String: String]] = []
    let className = "GetTogetherListViewController"
    
    func makeNotificationName(notificationName: NotificationName) -> String {
        className + notificationName.rawValue
    }
}
