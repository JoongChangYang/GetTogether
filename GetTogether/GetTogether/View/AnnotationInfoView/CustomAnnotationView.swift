//
//  CustomAnnotationView.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/07.
//  Copyright © 2020 didwndckd. All rights reserved.
//
//
import UIKit
import MapKit



class CustomAnnotationView: MKAnnotationView {
    
    let infoView = AnnotationInfoView()
    private var infoViewBottomConstraint = NSLayoutConstraint()
    private let size = UIScreen.main.bounds.width / 4
    private let titleLabel = UILabel()

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubview(infoView)
        addSubview(titleLabel)
        image = UIImage(named: "map_pin_red.png")
        setConstraint()
        
    }
    
    private func setConstraint() {
        
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.bottomAnchor.constraint(equalTo: topAnchor).isActive = true
        infoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoView.widthAnchor.constraint(equalToConstant: size).isActive = true
        infoViewBottomConstraint = infoView.topAnchor.constraint(equalTo: topAnchor)
        infoViewBottomConstraint.isActive = true
        
    }
    
    func configure(title: String?) {
        titleLabel.text = title
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            UIView.animate(withDuration: 0.15, animations: {
                self.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.infoViewBottomConstraint.constant = -self.size
                self.layoutIfNeeded()
            })
        }else {
            UIView.animate(withDuration: 0.15, animations: {
                self.transform = .identity
                self.infoViewBottomConstraint.constant = 0
                self.layoutIfNeeded()
            })
        }
    }
    
}
