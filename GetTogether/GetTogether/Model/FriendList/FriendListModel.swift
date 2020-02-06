//
//  FriendListModel.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import Foundation

class FriendListModel{

    private let className = "FriendListViewController"
    
    func makeNotificationKey(notificationName: NotificationName) -> String {
        className + notificationName.rawValue
    }

}
