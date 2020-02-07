//
//  HistoryTableViewCell.swift
//  #Productive
//
//  Created by Sohwi Jung on 11/23/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
  
    var waterLabel: UILabel!
    var exerciseLabel: UILabel!
    var moodLabel: UIImageView!
    var sleepLabel: UILabel!
    var dateLabel: UILabel!
    
    var waterText: UILabel!
    var exerciseText: UILabel!
    var sleepText: UILabel!
    
    let padding: CGFloat = 8
    let labelHeight: CGFloat = 16
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        waterLabel = UILabel()
        waterLabel.font = UIFont.systemFont(ofSize: 16)
        waterLabel.textColor = .black
        waterLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(waterLabel)
        
        waterText = UILabel()
        waterText.font = UIFont.systemFont(ofSize: 14)
        waterText.textColor = .darkGray
        waterText.translatesAutoresizingMaskIntoConstraints = false
        waterText.text = "Water"
        contentView.addSubview(waterText)
        
        exerciseText = UILabel()
        exerciseText.font = UIFont.systemFont(ofSize: 14)
        exerciseText.textColor = .darkGray
        exerciseText.translatesAutoresizingMaskIntoConstraints = false
        exerciseText.text = "Excercise"
        contentView.addSubview(exerciseText)
        
        sleepText = UILabel()
        sleepText.font = UIFont.systemFont(ofSize: 14)
        sleepText.textColor = .darkGray
        sleepText.translatesAutoresizingMaskIntoConstraints = false
        sleepText.text = "Sleep"
        contentView.addSubview(sleepText)
            
        exerciseLabel = UILabel()
        exerciseLabel.font = UIFont.systemFont(ofSize: 16)
        exerciseLabel.textColor = .black
        exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(exerciseLabel)
            
        moodLabel = UIImageView()
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        moodLabel.image = UIImage(named: "like")
        contentView.addSubview(moodLabel)
            
        sleepLabel = UILabel()
        sleepLabel.font = UIFont.systemFont(ofSize: 16)
        sleepLabel.textColor = .black
        sleepLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sleepLabel)
                
        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.textColor = .black
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
    NSLayoutConstraint.activate([
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -0.46*contentView.bounds.width),
        dateLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
    NSLayoutConstraint.activate([
        waterLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        waterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -0.1*contentView.bounds.height),
        waterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -0.21*contentView.bounds.width)
    ])
       NSLayoutConstraint.activate([
        exerciseLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        exerciseLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -0.1*contentView.bounds.height),
        exerciseLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.05*contentView.bounds.width)
    ])

    NSLayoutConstraint.activate([
        moodLabel.heightAnchor.constraint(equalToConstant: contentView.bounds.height*0.8),
        moodLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.height*0.8),
        moodLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
        moodLabel.centerXAnchor.constraint(equalTo: sleepLabel.trailingAnchor, constant: 0.16*contentView.bounds.width)
     //   moodLabel.leadingAnchor.constraint(equalTo: sleepLabel.trailingAnchor, constant: 0),
      //  moodLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
    ])
    NSLayoutConstraint.activate([
        sleepLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        sleepLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -0.1*contentView.bounds.height),
        sleepLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.28*contentView.bounds.width)
    ])
     
    NSLayoutConstraint.activate([
        sleepText.heightAnchor.constraint(equalToConstant: labelHeight),
        sleepText.centerYAnchor.constraint(equalTo: sleepLabel.centerYAnchor, constant: 0.45*contentView.bounds.height),
        sleepText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.28*contentView.bounds.width)
    ])
        
    NSLayoutConstraint.activate([
         exerciseText.heightAnchor.constraint(equalToConstant: labelHeight),
         exerciseText.centerYAnchor.constraint(equalTo: exerciseLabel.centerYAnchor, constant: 0.45*contentView.bounds.height),
         exerciseText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.05*contentView.bounds.width)
     ])
        
    NSLayoutConstraint.activate([
        waterText.heightAnchor.constraint(equalToConstant: labelHeight),
        waterText.centerYAnchor.constraint(equalTo: waterLabel.centerYAnchor, constant: 0.45*contentView.bounds.height),
        waterText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -0.21*contentView.bounds.width)
    ])
    
}
    func configure(for user: User) {
        waterLabel.text = "\(user.water) ml"
        exerciseLabel.text = "\(user.exercise) min"
        if (user.mood == 1){
            moodLabel.image = UIImage(named: "Miserable")
        }
        if (user.mood == 2){
            moodLabel.image = UIImage(named: "Dull")
        }
        if (user.mood == 3){
            moodLabel.image = UIImage(named: "Fine")
        }
        if (user.mood == 4){
            moodLabel.image = UIImage(named: "Well")
        }
        if (user.mood == 5){
            moodLabel.image = UIImage(named: "Cheerful")
        }
        sleepLabel.text = "\(user.sleep) hr"
        dateLabel.text = "\(user.date)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
}
