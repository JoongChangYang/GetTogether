//
//  MakePromiseView.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/07.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

protocol MakePromiseViewDelegate: class {
    func makePromise(comment: String, date: Date)
}

class MakePromiseView: UIView {
    
    weak var delegate: MakePromiseViewDelegate?
    
    private let scrollView = UIScrollView()
    
    private let memberLable = UILabel()
    let tableView = UITableView()
   
    private let dateLable = UILabel()
    private let datePicker = UIDatePicker()
    
    private let commentLable = UILabel()
    private let commentTextField = UITextField()
    
    private let makePromiseButton = UIButton(type: .system)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    private func setupUI() {
        backgroundColor = .white
        
        
        addSubViews([scrollView])
        scrollView.addSubViews([memberLable, tableView, dateLable, commentLable, datePicker, commentTextField, makePromiseButton])
        
        memberLable.text = "멤버"
        memberLable.font = .boldSystemFont(ofSize: 20)
        
        dateLable.text = "시간"
        dateLable.font = .boldSystemFont(ofSize: 20)
        
        commentLable.text = "한마디"
        commentLable.font = .boldSystemFont(ofSize: 20)
        
        commentTextField.borderStyle = .roundedRect
        
        makePromiseButton.setTitle("약속 잡기", for: .normal)
        makePromiseButton.backgroundColor = ThemeColor.basic
        makePromiseButton.tintColor = .white
        makePromiseButton.layer.cornerRadius = 16
        makePromiseButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        tableView.register(FriendListCell.self, forCellReuseIdentifier: "MakePromise")
        tableView.allowsMultipleSelection = true
        datePicker.minimumDate = Date()
        
        setupConstraint()
        
    }
    
    @objc func didTapButton() {
        let comment = commentTextField.text ?? ""
        delegate?.makePromise(comment: comment, date: datePicker.date)
    }
    
    private func setupConstraint() {
        let margin: CGFloat = 8
        let verticalMargin: CGFloat = margin * 2
        
        scrollView.layout.top().bottom().leading().trailing()
        
        commentLable.translatesAutoresizingMaskIntoConstraints = false
        commentLable.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: verticalMargin).isActive = true
        commentLable.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin).isActive = true
        commentLable.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin).isActive = true
        commentLable.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(margin * 2)).isActive = true
        
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.topAnchor.constraint(equalTo: commentLable.bottomAnchor, constant: verticalMargin).isActive = true
        commentTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin).isActive = true
        commentTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin).isActive = true
        commentTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(margin * 2)).isActive = true
        
        memberLable.translatesAutoresizingMaskIntoConstraints = false
        memberLable.topAnchor.constraint(equalTo: commentTextField.bottomAnchor, constant: verticalMargin).isActive = true
        memberLable.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin).isActive = true
        memberLable.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin).isActive = true
        memberLable.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(margin * 2)).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: memberLable.bottomAnchor, constant: verticalMargin).isActive = true
        tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin).isActive = true
        tableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin).isActive = true
        tableView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5).isActive = true
        tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(margin * 2)).isActive = true
        
        dateLable.translatesAutoresizingMaskIntoConstraints = false
        dateLable.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: verticalMargin).isActive = true
        dateLable.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin).isActive = true
        dateLable.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin).isActive = true
        dateLable.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(margin * 2)).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: dateLable.bottomAnchor, constant: verticalMargin).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin).isActive = true
        datePicker.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.4).isActive = true
        datePicker.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(margin * 2)).isActive = true
        
        makePromiseButton.translatesAutoresizingMaskIntoConstraints = false
        makePromiseButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: verticalMargin).isActive = true
        makePromiseButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin).isActive = true
        makePromiseButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin).isActive = true
        makePromiseButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.1).isActive = true
        makePromiseButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -verticalMargin).isActive = true
        makePromiseButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(margin * 2)).isActive = true
        
    }
    
    
}
