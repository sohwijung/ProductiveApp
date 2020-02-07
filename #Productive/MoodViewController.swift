//
//  MoodViewController.swift
//  #Productive
//
//  Created by Sohwi Jung on 11/19/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import UIKit

class MoodViewController: UIViewController {

    var moodLabel: UILabel!
    var miserableButton: UIButton!
    var dullButton: UIButton!
    var fineButton: UIButton!
    var wellButton: UIButton!
    var cheerfulButton: UIButton!

    var moodIcon: UIImageView!
    

    var currentMood: Int = 0
    
    weak var delegate: ReceiveInformation?
         
    override func viewDidDisappear(_ animated: Bool) {
        print("this is the current mood \(currentMood)")
             delegate?.moodValueChanged(to: currentMood)
        var value = 0
              if moodLabel.text == "Miserable"{
                  value = 1
              }
              if moodLabel.text == "Dull"{
                  value = 2
              }
              if moodLabel.text == "Fine"{
                  value = 3
              }
              if moodLabel.text == "Well"{
                  value = 4
              }
              if moodLabel.text == "Cheerful"{
                  value = 5
              }
        
        NetworkManager.postMood(username: userDefaults.string(forKey: "username")!, date: ViewController.currentDate, update_to: value)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        moodLabel = UILabel()
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        moodLabel.text = "How are you feeling today?"
        moodLabel.textColor = .black
        moodLabel.textAlignment = .center
        moodLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(moodLabel)
        
        NetworkManager.getData(username: "kj228", date: ViewController.currentDate) { responseData in
            self.currentMood = responseData.mood_data
            if Int(responseData.mood_data) == 1 {
                self.moodLabel.text = "Miserable"
            }
            if Int(responseData.mood_data) == 2 {
                self.moodLabel.text = "Dull"
            }
            if Int(responseData.mood_data) == 3 {
                self.moodLabel.text = "Fine"
            }
            if Int(responseData.mood_data) == 4 {
                self.moodLabel.text = "Well"
            }
            if Int(responseData.mood_data) == 5 {
                self.moodLabel.text = "Cheerful"
            }
        self.moodIcon.image = UIImage(named: self.moodLabel.text!)
        }
        
        miserableButton = UIButton()
        miserableButton.translatesAutoresizingMaskIntoConstraints = false
        let miserableImage = UIImage(named: "Miserable")
        miserableButton.setImage(miserableImage, for: UIControl.State.normal)
        miserableButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        view.addSubview(miserableButton)

        dullButton = UIButton()
        dullButton.translatesAutoresizingMaskIntoConstraints = false
        let dullImage = UIImage(named: "Dull")
        dullButton.setImage(dullImage, for: UIControl.State.normal)
        dullButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        view.addSubview(dullButton)
        
        fineButton = UIButton()
        fineButton.translatesAutoresizingMaskIntoConstraints = false
        let fineImage = UIImage(named: "Fine")
        fineButton.setImage(fineImage, for: UIControl.State.normal)
        fineButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        view.addSubview(fineButton)
        
        wellButton = UIButton()
        wellButton.translatesAutoresizingMaskIntoConstraints = false
        let wellImage = UIImage(named: "Well")
        wellButton.setImage(wellImage, for: UIControl.State.normal)
        wellButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        view.addSubview(wellButton)
        
        cheerfulButton = UIButton()
        cheerfulButton.translatesAutoresizingMaskIntoConstraints = false
        let cheerfulImage = UIImage(named: "Cheerful")
        cheerfulButton.setImage(cheerfulImage, for: UIControl.State.normal)
        cheerfulButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        view.addSubview(cheerfulButton)
        
        moodIcon = UIImageView()
        moodIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moodIcon)
        
        setupConstraints()

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            moodLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.2),
            moodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        NSLayoutConstraint.activate([
            moodIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moodIcon.heightAnchor.constraint(equalToConstant: CGFloat(100)),
            moodIcon.widthAnchor.constraint(equalToConstant: CGFloat(100)),
            moodIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.bounds.height*(-0.05)),
        ])
        NSLayoutConstraint.activate([
            cheerfulButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: (view.bounds.width)*(-0.3)),
            cheerfulButton.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.65),
        ])
        NSLayoutConstraint.activate([
            wellButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wellButton.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.65),
        ])
        NSLayoutConstraint.activate([
            fineButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: (view.bounds.width)*(0.3)),
            fineButton.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.65),
        ])
        NSLayoutConstraint.activate([
            dullButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: (view.bounds.width)*(-0.15)),
            dullButton.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.78),
        ])
        NSLayoutConstraint.activate([
            miserableButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: (view.bounds.width)*(0.15)),
            miserableButton.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.78),
        ])


    }
        
    

    
    
    @objc func addImage() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//        dateFormatter.timeStyle = .none
//        let dateString = dateFormatter.string(from: Date())
        
//        displayDescription.text = ""
//        if happyButton.isTouchInside == true {
//            NetworkManager.postMood(username: "", date: dateString, update_to: happyDescription)
//        }
//        if smilingButton.isTouchInside == true {
//            NetworkManager.postMood(username: "", date: dateString, update_to: smilingDescription)
//        }
//        if yummyButton.isTouchInside == true {
//            NetworkManager.postMood(username: "", date: dateString, update_to: yummyDescription)
//        }
//        if grinningButton.isTouchInside == true {
//            NetworkManager.postMood(username: "", date: dateString, update_to: grinningDescription)
//        }
//        if unhappyButton.isTouchInside == true {
//            NetworkManager.postMood(username: "", date: dateString, update_to: unhappyDescription)
//        }
//        if angryButton.isTouchInside == true {
//            NetworkManager.postMood(username: "", date: dateString, update_to: angryDescription)
//        }

        
        var displayImage = ""

        if cheerfulButton.isTouchInside == true {
            displayImage = "Cheerful"
            currentMood = 5
        }
        if wellButton.isTouchInside == true {
            displayImage = "Well"
            currentMood = 4
        }
        if fineButton.isTouchInside == true {
            displayImage = "Fine"
            currentMood = 3
        }
        if dullButton.isTouchInside == true {
            displayImage = "Dull"
            currentMood = 2
        }
        if miserableButton.isTouchInside == true {
            displayImage = "Miserable"
            currentMood = 1
        }
        
        moodLabel.text = displayImage
        
        self.moodIcon.image = UIImage(named: displayImage)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        var value = 0
//        if moodLabel.text == "happy"{
//            value = 1
//        }
//        if moodLabel.text == "smiling"{
//            value = 2
//        }
//        if moodLabel.text == "yummy"{
//            value = 3
//        }
//        if moodLabel.text == "grinning"{
//            value = 4
//        }
//        if moodLabel.text == "unhappy"{
//            value = 5
//        }
//        if moodLabel.text == "angry"{
//            value = 6
//        }
//        NetworkManager.postMood(username: "kj228", date: "26112019", update_to: value)
//    }
    
//    @objc func getMood() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//        dateFormatter.timeStyle = .none
//        let dateString = dateFormatter.string(from: Date())
//
//        NetworkManager.getMood(username: "", date: dateString) { (getMoodDescription) in
//            self.displayDescription.text = "\(getMoodDescription)"
//        }
//    }

        func dismissViewControllerAndSaveText() {
        navigationController?.popViewController(animated: true)
    }
    
        func goesBack() {
        navigationController?.popViewController(animated: true)
    }


}
