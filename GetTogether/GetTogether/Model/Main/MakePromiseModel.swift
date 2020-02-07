//
//  MakePromiseModel.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/07.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import Foundation

struct MakePromiseModel: Codable {
    
    var members: [[String: String]] = [[:]]
    var placeTitle: String
    var comment: String?
    var date: Date?
    var coordinate: Coordinate
    var addressName: String
    
    func makeNotificationKey(_ makeCase: MakePromiseCase) -> String {
        "MakePromiseViewController" + makeCase.rawValue
    }
    
    
}
