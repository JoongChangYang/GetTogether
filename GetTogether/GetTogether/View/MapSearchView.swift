//
//  MapSearchView.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/03.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit
import MapKit

class MapSearchView: UIView {
    
    private let mapView = MKMapView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubViews([mapView])
        backgroundColor = .white
        mapView.layout.top().leading().trailing().bottom()
    }
    
    
}
