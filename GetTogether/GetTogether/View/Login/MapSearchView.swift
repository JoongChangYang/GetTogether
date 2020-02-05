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
    
     let mapView = MKMapView()

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
    
    
    func addAnnotation(addressName: String, coordinate: Coordinate) {
        
        let annotation = MKPointAnnotation()
        annotation.title = addressName
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        mapView.addAnnotation(annotation)
        
        setRegion(coordinate: coordinate)
    }
    
    func setRegion(coordinate: Coordinate) {
        
        let coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let spen = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: coordinate, span: spen)
        mapView.setRegion(region, animated: true)
    }
    
}
