//
//  AddFriendModel.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import Foundation
import UIKit

struct addFriendModel {
    
    var searchResult: [[String: String]] = []
    let className = "AddFriendViewController"
    
    func makeNotificationName(notificationName: NotificationName) -> String {
        className + notificationName.rawValue
    }
    
    
}
