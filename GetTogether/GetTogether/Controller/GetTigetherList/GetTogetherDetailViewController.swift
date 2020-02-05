//
//  GetTogetherDetailViewController.swift
//  GetTogether
//
//  Created by Hailey Lee on 2020/02/05.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit
import MapKit

class GetTogetherDetailViewController: UIViewController {
    
    var promisses = [Promise]()
    let mapView = MKMapView()
    let cardBg = UIView()
    let commentLabel = UILabel()
    let memberLabel = UILabel()
    
//    let today = Date()
//    // 하루는 초로 86400이다. (60*60*24 = 86400)
//    let tomorrow = Date(timeIntervalSinceNow:86400)
//    let yesterday = Date(timeIntervalSinceNow:-86400)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
//        print(tomorrow)
    }
    private func setUI() {
        view.backgroundColor = .white
        cardBg.backgroundColor = .white
        cardBg.layer.cornerRadius = 4
        cardBg.shadow()
        self.navigationItem.title = "날짜"
        commentLabel.textColor = .black
        commentLabel.font = UIFont.systemFont(ofSize: 24)
        setupConstraint()
    }
    
    private func setupConstraint() {
        [mapView, cardBg, commentLabel, memberLabel].forEach {
            view.addSubview($0)
        }
        
        let guide = self.view.safeAreaLayoutGuide
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: guide.topAnchor,constant: 0),
            mapView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0)
        ])
        
        cardBg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardBg.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -18),
            cardBg.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 18),
            cardBg.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -18),
            cardBg.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.91),
            cardBg.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.4)
        ])
        
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: cardBg.topAnchor, constant: 24),
            commentLabel.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor, constant: 24),
        ])
        
        memberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memberLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 18),
            memberLabel.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor, constant: 24)])
    }
    
    func setData() {
        for i in 0...20 {
            let promiss = Promise(date: Date(), members: "memebers \(i)", placeTitle: "placeTitle \(i)", placeLatitude: Double(i), placeLongitude: Double(i), comment: "comment \(i)")
            promisses.append(promiss)
        }
    }

}
