//
//  FriendListCell.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/06.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class UserImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
        
    }
    
}

class FriendListCell: UITableViewCell {
    
    private let userImageView = UserImageView(frame: .zero)
    private let nickNameLabel = UILabel()
    private let idLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubViews([userImageView, nickNameLabel, idLabel])
        
        userImageView.tintColor = .white
        userImageView.contentMode = .scaleAspectFit
        userImageView.backgroundColor = ThemeColor.basic
        
        
        nickNameLabel.font = .boldSystemFont(ofSize: 20)
        
        idLabel.font = .systemFont(ofSize: 12)
        idLabel.textColor = .darkGray
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        
        let margin: CGFloat = 10
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin * 2).isActive = true
        userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin).isActive = true
        userImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin).isActive = true
        userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor).isActive = true
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: margin * 2).isActive = true
        nickNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin * 1.5).isActive = true
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: margin * 2).isActive = true
        idLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: margin / 2).isActive = true
        idLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(margin * 1.5)).isActive = true
        
        
    }
    
    func configure(id: String?, nickName: String?, image: UIImage?) {
        
        let image = image ?? UIImage(systemName: "person")
        
        idLabel.text = id
        nickNameLabel.text = nickName
        userImageView.image = image
        
    }
    
  
//
//    override func layoutMarginsDidChange() {
//        super.layoutMarginsDidChange()
//        userImageView.layer.cornerRadius = userImageView.frame.width / 2
//        print(userImageView.frame)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        print(userImageView.frame)
//    }
    
    
    
}
