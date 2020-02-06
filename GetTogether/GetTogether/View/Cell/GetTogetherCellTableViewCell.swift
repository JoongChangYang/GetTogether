
//  GetTogetherCell.swift
//  GetTogether
//
//  Created by Hailey Lee on 2020/02/03.
//  Copyright © 2020 didwndckd. All rights reserved.
//
import UIKit

class DateLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = ""
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class GetTogetherCell: UITableViewCell {
    let commentLable = UILabel()
    var timeLabel: UILabel!
    var placeTitleLabel: UILabel!
    var membersLabel: UILabel!
    let dateBg = UIView()
    var monthLabel: UILabel!
    let dayLabel = UILabel()
    var weekDayLabel: UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commentLable.textColor = .black
        commentLable.font = UIFont.systemFont(ofSize: 24)
        
        timeLabel = self.labelStyle()
        placeTitleLabel = self.labelStyle()
        membersLabel = self.labelStyle()
        
        dateBg.backgroundColor = #colorLiteral(red: 0.9465712905, green: 0.9436327815, blue: 0.9488766789, alpha: 1)
        monthLabel = self.dateLabelStyle()
        
        dayLabel.textColor = .darkGray
        dayLabel.font = UIFont.systemFont(ofSize: 32)
        
        weekDayLabel = self.dateLabelStyle()
        self.setupConstraint()
    }
    func setupConstraint() {
        [commentLable, timeLabel, placeTitleLabel, membersLabel, dateBg, monthLabel, dayLabel, weekDayLabel].forEach {
            contentView.addSubview($0)
        }
        let margin: CGFloat = 18
        let padding: CGFloat = 4
        dateBg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateBg.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
            dateBg.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            dateBg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateBg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin)
        ])
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            monthLabel.centerXAnchor.constraint(equalTo: dateBg.centerXAnchor, constant: 0),
            monthLabel.centerYAnchor.constraint(equalTo: dateBg.centerYAnchor, constant: -32)
        ])
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: dateBg.centerXAnchor, constant: 0),
            dayLabel.centerYAnchor.constraint(equalTo: dateBg.centerYAnchor, constant: 0)
        ])
        weekDayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekDayLabel.centerXAnchor.constraint(equalTo: dateBg.centerXAnchor, constant: 0),
            weekDayLabel.centerYAnchor.constraint(equalTo: dateBg.centerYAnchor, constant: 32)
        ])
        commentLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentLable.topAnchor.constraint(equalTo: contentView.topAnchor,constant: margin),
            commentLable.leadingAnchor.constraint(equalTo: dateBg.trailingAnchor, constant: margin),
            commentLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin)
        ])
//        membersLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            membersLabel.topAnchor.constraint(equalTo: commentLable.bottomAnchor,constant: padding),
//            membersLabel.leadingAnchor.constraint(equalTo: dateBg.trailingAnchor, constant: margin),
//            membersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
//        ])
        
     timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
         timeLabel.topAnchor.constraint(equalTo: commentLable.bottomAnchor,constant: padding),
         timeLabel.leadingAnchor.constraint(equalTo: dateBg.trailingAnchor, constant: margin),
         timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
        ])
        
        placeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeTitleLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: padding),
            placeTitleLabel.leadingAnchor.constraint(equalTo: dateBg.trailingAnchor, constant: margin),
            placeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            placeTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin)
        ])
    }
    func commentLabelInfo(comment: String) {
        commentLable.text = comment
        commentLable.numberOfLines = 0
    }
    func timeLabelInfo(time: String) {
        timeLabel.text = time
        timeLabel.numberOfLines = 0
    }
    func placeTitleLabelInfo(placeTitle: String) {
        placeTitleLabel.text = placeTitle
        placeTitleLabel.numberOfLines = 0
    }
    func membersLabelInfo(members: String) {
        membersLabel.text = members
        membersLabel.numberOfLines = 0
    }
    func monthLabelInfo(month: String) {
        monthLabel.text = month
        monthLabel.numberOfLines = 0
    }
    func dayLabelInfo(day: String) {
        dayLabel.text = day
        dayLabel.numberOfLines = 0
    }
    func weekDayLabelInfo(weekDay: String) {
        weekDayLabel.text = weekDay
        weekDayLabel.numberOfLines = 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateConstraints() {
        super.updateConstraints()
    }
    func labelStyle() -> UILabel {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }
    func dateLabelStyle() -> UILabel {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }
    // 이 아래는 TableViewCell로 파일 만들었더니 원래 있었던 코드 나중에 필요할까 싶어서 내둠
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
