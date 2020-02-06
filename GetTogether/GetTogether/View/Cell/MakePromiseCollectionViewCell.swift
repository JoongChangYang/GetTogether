//
//  MakePromiseCollectionViewCell.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/07.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class MakePromiseCollectionViewCell: UICollectionViewCell {
    
    private let userImageView = UserImageView(frame: .zero)
    private let nickNameLabel = UILabel()
    private let idLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
           
           contentView.addSubViews([userImageView, nickNameLabel, idLabel])
           
           userImageView.tintColor = .white
           userImageView.contentMode = .scaleToFill
           userImageView.backgroundColor = ThemeColor.basic
           
           
           nickNameLabel.font = .boldSystemFont(ofSize: 20)
           
           idLabel.font = .systemFont(ofSize: 12)
           
           setupConstraint()
       }
       
       private func setupConstraint() {
           
           let margin: CGFloat = 8
           
           userImageView.translatesAutoresizingMaskIntoConstraints = false
           userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin).isActive = true
           userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin / 2).isActive = true
           userImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(margin / 2)).isActive = true
           userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor).isActive = true
           
           nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
           nickNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: margin * 2).isActive = true
           nickNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin * 1.5).isActive = true
           
           idLabel.translatesAutoresizingMaskIntoConstraints = false
           idLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: margin * 2).isActive = true
           idLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor).isActive = true
           idLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(margin * 1.5)).isActive = true
           
           
       }
       
       func configure(id: String?, nickName: String?, image: UIImage?) {
           
           let image = image ?? UIImage(systemName: "person")
           
           idLabel.text = id
           nickNameLabel.text = nickName
           userImageView.image = image
           
       }
    
    
}
