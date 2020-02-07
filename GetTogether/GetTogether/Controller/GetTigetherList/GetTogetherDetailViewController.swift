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
    let placeTitleLabel = UILabel()
    let placeAdressLabel = UILabel()
    let line = UIView()
    var dayIcon = UIImageView()
    let dayLabel = UILabel()
    let timeLabel = UILabel()
    var timeIcon = UIImageView()
    var memberIcon = UIImageView()
    var memberLabel = UILabel()
    var commentLabel = UILabel()
    var commentIcon = UIImageView()

    
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
        
        placeTitleLabel.textColor = .black
        placeTitleLabel.font = UIFont.systemFont(ofSize: 28)
        
        placeAdressLabel.numberOfLines = 0
        placeAdressLabel.font = UIFont.systemFont(ofSize: 18)
        
        line.backgroundColor = #colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)
        
        infoLabelStyle(label: dayLabel)
        infoLabelStyle(label: timeLabel)
        infoLabelStyle(label: memberLabel)
        titleLabelStyle(label: commentLabel)

        dayIcon = self.iconStyle(name: "calendar")
        timeIcon = self.iconStyle(name: "clock")
        memberIcon = self.iconStyle(name: "person.2")
        commentIcon = self.iconStyle(name: "info.circle.fill")
        
        setupConstraint()
        
    }
    
    private func setupConstraint() {
        [mapView, cardBg, placeTitleLabel, placeAdressLabel, line, dayLabel, dayIcon, timeIcon, timeLabel, memberIcon, memberLabel, commentLabel, commentIcon].forEach {
            view.addSubview($0)
        }
        
        let guide = self.view.safeAreaLayoutGuide
        let margin: CGFloat = 18
        let padding: CGFloat = 24
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: guide.topAnchor,constant: 0),
            mapView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0)
        ])
        
        cardBg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardBg.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -margin),
            cardBg.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: margin),
            cardBg.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -margin),
            cardBg.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.91)
        ])
        
        placeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeTitleLabel.topAnchor.constraint(equalTo: cardBg.topAnchor, constant: padding),
            placeTitleLabel.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor, constant: padding),
            placeTitleLabel.trailingAnchor.constraint(equalTo: cardBg.trailingAnchor, constant: -padding)
        ])
        
        placeTitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        placeAdressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeAdressLabel.topAnchor.constraint(equalTo: placeTitleLabel.bottomAnchor, constant: margin),
            placeAdressLabel.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor, constant: padding),
            placeAdressLabel.trailingAnchor.constraint(equalTo: cardBg.trailingAnchor, constant: -padding),
//            placeAdressLabel.bottomAnchor.constraint(equalTo: line.topAnchor, constant: -padding)
        ])
        
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: placeAdressLabel.bottomAnchor, constant: margin),
            line.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor, constant: padding),
            line.trailingAnchor.constraint(equalTo: cardBg.trailingAnchor, constant: -margin),
            line.heightAnchor.constraint(equalToConstant: 0.8)
        ])
        
        commentIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentIcon.topAnchor.constraint(equalTo: line.bottomAnchor, constant: padding),
            commentIcon.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor, constant: padding),
            commentIcon.bottomAnchor.constraint(equalTo: dayIcon.topAnchor, constant: -padding)
        ])
        
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: margin),
            commentLabel.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: margin),
            commentLabel.trailingAnchor.constraint(equalTo: cardBg.trailingAnchor, constant: -margin)
        ])
        
        
        dayIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayIcon.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: margin),
            dayIcon.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor, constant: padding),
            dayIcon.bottomAnchor.constraint(equalTo: timeIcon.topAnchor, constant: -padding)
        ])
        
        dayIcon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: margin),
            dayLabel.leadingAnchor.constraint(equalTo: dayIcon.trailingAnchor, constant: margin),
            dayLabel.trailingAnchor.constraint(equalTo: cardBg.trailingAnchor, constant: -margin)
        ])
        
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeIcon.topAnchor.constraint(equalTo: dayIcon.bottomAnchor, constant: margin),
            timeIcon.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor, constant: padding),
            timeIcon.bottomAnchor.constraint(equalTo: memberIcon.topAnchor, constant: -padding)
        ])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: margin),
            timeLabel.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: margin),
            timeLabel.trailingAnchor.constraint(equalTo: cardBg.trailingAnchor, constant: -margin)
        ])
        
        memberIcon.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                memberIcon.topAnchor.constraint(equalTo: timeIcon.bottomAnchor, constant: margin),
                memberIcon.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor, constant: margin),
                memberIcon.bottomAnchor.constraint(equalTo: cardBg.bottomAnchor, constant: -padding)
            ])
        
        memberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memberLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: margin),
            memberLabel.leadingAnchor.constraint(equalTo: memberIcon.trailingAnchor, constant: margin),
            memberLabel.trailingAnchor.constraint(equalTo: cardBg.trailingAnchor, constant: -margin),
            memberLabel.bottomAnchor.constraint(equalTo: cardBg.bottomAnchor, constant: -padding)
        ])
    }
    
    
    func infoLabelStyle(label: UILabel) {
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 20)
    }
    
    func titleLabelStyle(label: UILabel) {
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func iconStyle(name: String) -> UIImageView {
        let icon = UIImageView()
        icon.image = UIImage(systemName: name)
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .darkGray
        return icon
    }
}

