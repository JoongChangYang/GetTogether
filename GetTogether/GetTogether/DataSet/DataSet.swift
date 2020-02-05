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
