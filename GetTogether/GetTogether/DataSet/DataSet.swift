//
//  DataSet.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/03.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import Foundation
import UIKit

struct Promise: Codable {
    let date: String
    let members: String
    let placeTitle: String
    let placeLatitude: Double // 위도
    let placeLongitude: Double // 경도
    let comment: String
}

struct Coordinate: Codable {
    let x: Double
    let y: Double
    
}
