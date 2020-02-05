//
//  SetUpModel.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import Foundation

struct setupModel {
    let id: String?
    init() {
        let id = UserDefaults.standard.string(forKey: "id") ?? ""
        self.id = id
    }
    
    private func setupData() {
        
    }
    
    
}
