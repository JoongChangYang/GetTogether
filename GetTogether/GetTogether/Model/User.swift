//
//  User.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/02.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import Foundation


class User {
    
    let id: String
    let pw: String?
    let nickName: String
    let address: String
    let image: String?
    
    init(id: String, nickName: String, address: String, pw: String? = nil, image: String? = nil) {
        self.id = id
        self.pw = pw
        self.nickName = nickName
        self.address = address
        self.image = image
    }
    
    
    
}
