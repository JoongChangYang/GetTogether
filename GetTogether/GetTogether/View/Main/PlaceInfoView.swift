////
////  PlaceInfoView.swift
////  GetTogether
////
////  Created by 양중창 on 2020/02/07.
////  Copyright © 2020 didwndckd. All rights reserved.
////
//
//import UIKit
//
//
//protocol PlaceInfoViewDelegate: class {
//    func makePromise()
//    func close()
//}
//
//class PlaceInfoView: UIView {
//
//    private let placeNameLabel = UILabel()
//    private let roadAddressLabel = UILabel()
//    private let addressNameLabel = UILabel()
//    private let placeUrlLabel = UILabel()
//    private let promissButton = UIButton(type: .system)
//    private let closeButton = UIButton(type: .system)
//    weak var delegate: PlaceInfoViewDelegate?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupUI() {
//        backgroundColor = .white
//        transform = .init(scaleX: 0, y: 0)
//        isHidden = true
//
//        placeNameLabel.font = .boldSystemFont(ofSize: 20)
//
//        addressNameLabel.font = .systemFont(ofSize: 16)
//
//        promissButton.backgroundColor = ThemeColor.basic
//        promissButton.setTitle("약속 잡기", for: .normal)
//        promissButton.tintColor = .white
//        promissButton.addTarget(self, action: #selector(makePromiss), for: .touchUpInside)
//
//        closeButton.setTitle("X", for: .normal)
//        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
//
//
//        addSubViews([placeNameLabel, roadAddressLabel, addressNameLabel, placeUrlLabel, promissButton, closeButton])
//
//        setupConstraint()
//    }
//
//    @objc func makePromiss() {
//        delegate?.makePromise()
//    }
//
//    @objc func didTapCloseButton() {
//        delegate?.close()
//    }
//
//    func contfigure(placeName: String?, roadAddress: String?, adddressName: String?, placeUrl: String?) {
//
//        placeNameLabel.text = placeName
//        roadAddressLabel.text = roadAddress
//        addressNameLabel.text = adddressName
//        placeUrlLabel.text = placeUrl
//
//    }
//
//
//
//
//    private func setupConstraint() {
//        let margin: CGFloat = 8
//
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
//        closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin / 2).isActive = true
//
//
//        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        placeNameLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: margin * 2).isActive = true
//        placeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
//        placeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
//
//        roadAddressLabel.translatesAutoresizingMaskIntoConstraints = false
//        roadAddressLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: margin).isActive = true
//        roadAddressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
//        roadAddressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
//
//        addressNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        addressNameLabel.topAnchor.constraint(equalTo: roadAddressLabel.bottomAnchor, constant: margin).isActive = true
//        addressNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
//        addressNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
//
//        placeUrlLabel.translatesAutoresizingMaskIntoConstraints = false
//        placeUrlLabel.topAnchor.constraint(equalTo: addressNameLabel.bottomAnchor, constant: margin).isActive = true
//        placeUrlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
//        placeUrlLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
//
//        promissButton.translatesAutoresizingMaskIntoConstraints = false
//        promissButton.topAnchor.constraint(equalTo: placeUrlLabel.bottomAnchor, constant: margin).isActive = true
//        promissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
//        promissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
//
//
//    }
//
//}



//
//  PlaceInfoView.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/07.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit


protocol PlaceInfoViewDelegate: class {
    func makePromise()
    func close()
}

class PlaceInfoView: UIView {
    
    private let placeNameLabel = UILabel()
    private let roadAddressLabel = UILabel()
    private let addressNameLabel = UILabel()
    private let placeUrlLabel = UILabel()
    private let promissButton = UIButton(type: .system)
    private let closeButton = UIButton(type: .system)
    weak var delegate: PlaceInfoViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        transform = .init(scaleX: 0, y: 0)
        isHidden = true
        
        
        
        placeNameLabel.font = .systemFont(ofSize: 26)
        roadAddressLabel.font = .systemFont(ofSize: 16)
        addressNameLabel.font = .systemFont(ofSize: 16)
        addressNameLabel.textColor = .darkGray
        
        promissButton.backgroundColor = ThemeColor.basic
        promissButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        promissButton.layer.cornerRadius = 4
        promissButton.shadow()
        promissButton.setTitle("약속 잡기", for: .normal)
        promissButton.tintColor = .white
        promissButton.addTarget(self, action: #selector(makePromiss), for: .touchUpInside)
        
        closeButton.setTitle("✕", for: .normal)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
        
        addSubViews([placeNameLabel, roadAddressLabel, addressNameLabel, placeUrlLabel, promissButton, closeButton])
        
        setupConstraint()
    }
    
    @objc func makePromiss() {
        delegate?.makePromise()
    }
    
    @objc func didTapCloseButton() {
        delegate?.close()
    }
    
    func contfigure(placeName: String?, roadAddress: String?, adddressName: String?, placeUrl: String?) {
        
        placeNameLabel.text = "📍 " + (placeName ?? "")
        roadAddressLabel.text = roadAddress
        addressNameLabel.text = (adddressName ?? "") + " (지번)"
        placeUrlLabel.text = placeUrl
        
    }
    
    
    
    
    private func setupConstraint() {
        let padding: CGFloat = 24
        let margin: CGFloat = 18
        let height: CGFloat = 56
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        
        
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor).isActive = true
        placeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        placeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        
        roadAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        roadAddressLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: padding).isActive = true
        roadAddressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        roadAddressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        
        addressNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressNameLabel.topAnchor.constraint(equalTo: roadAddressLabel.bottomAnchor, constant: margin).isActive = true
        addressNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        addressNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        
        placeUrlLabel.translatesAutoresizingMaskIntoConstraints = false
        placeUrlLabel.topAnchor.constraint(equalTo: addressNameLabel.bottomAnchor, constant: margin).isActive = true
        placeUrlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        placeUrlLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        
        promissButton.translatesAutoresizingMaskIntoConstraints = false
        promissButton.topAnchor.constraint(equalTo: placeUrlLabel.bottomAnchor, constant: margin).isActive = true
        promissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        promissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        promissButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
    
        promissButton.heightAnchor.constraint(equalToConstant: height).isActive = true
                
    }
    
}
