//
//  SignupModel.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/02.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import Foundation



struct SignupModel {
    private let className = "SignUpViewController"
    var coordinate: Coordinate?
    
    mutating func makeNotificationName(notificationName: NotificationName) -> String {
        className + notificationName.rawValue
    }
    
}
