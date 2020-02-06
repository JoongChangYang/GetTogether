//
//  SearchMapCell.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/06.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class SearchMapCell: UITableViewCell {
    
    let placeNameLabel = UILabel()
    let roadAddressLabel = UILabel()
    let addressNameLabel = UILabel()
    let placeUrlLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubViews([placeNameLabel, roadAddressLabel, addressNameLabel, placeUrlLabel])
        
        
    }
    
    
    
}
