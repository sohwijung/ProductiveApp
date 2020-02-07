//
//  ExerciseViewController.swift
//  #Productive
//
//  Created by Sohwi Jung on 11/19/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {

    var exerciseLabel: UILabel!
    var lengthSlider: UISlider!
    var lengthLabel: UILabel!
    var excericseDuration: Float

    var dumbbellIcon: UIImageView!
    
    weak var delegate: ReceiveInformation?
        
    init(duration: Float){
        self.excericseDuration = duration
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // two functions, one where if onecup pressed, add oneupvalue to currentwater
    // one where when currentWAter >= waterGoal, animation
    // when onecup pressed img grows by two, onebottle by 5, oneliter by 10, there will be 20
        
    override func viewDidDisappear(_ animated: Bool) {
            delegate?.exerciseValueChanged(to: Int(lengthSlider.value))
        let finalDurationValue = Int(lengthSlider.value)
        NetworkManager.postExercise(username: userDefaults.string(forKey: "username")!, date: ViewController.currentDate, update_to_duration: finalDurationValue)
    }
    
// append value of title of button to workout for day and store them in array

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        exerciseLabel = UILabel()
        exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        exerciseLabel.text = "Exercise"
        exerciseLabel.textColor = .black
        exerciseLabel.textAlignment = .center
        exerciseLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(exerciseLabel)
        
        lengthSlider = UISlider()
        lengthSlider.minimumValue = 0
        lengthSlider.maximumValue = 180
        lengthSlider.translatesAutoresizingMaskIntoConstraints = false
        lengthSlider.addTarget(self, action: #selector(lengthChange), for: .touchDragInside)
        lengthSlider.tintColor = .purple
        lengthSlider.value = excericseDuration
        view.addSubview(lengthSlider)
//        NetworkManager.getData(username: "kj228", date: "26112019") { responseData in
//            self.excericseDuration = Float(responseData.fitness_data_duration)
//                 self.lengthSlider.value = self.excericseDuration
//        print(1)
//        print(self.lengthSlider.value)
//        }
        print(2)
        print(lengthSlider.value)
        lengthLabel = UILabel()
        lengthLabel.translatesAutoresizingMaskIntoConstraints = false
        lengthLabel.textColor = .gray
        lengthLabel.textAlignment = .center
        lengthLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        print(3)
        print(lengthSlider.value)
        lengthLabel.text = "\(Int(excericseDuration))" + " minutes"
        print(4)
        print(lengthLabel.text as Any)
        view.addSubview(lengthLabel)
        
        
        
        dumbbellIcon = UIImageView()
        dumbbellIcon.image = UIImage(named: "dumbbell1")
        dumbbellIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dumbbellIcon)
        
        var sizeImage = "dumbbell1"
        if lengthSlider.value <= 30 && lengthSlider.value >= 60 {
            sizeImage = "dumbbell2"
        }
        if lengthSlider.value >= 60 && lengthSlider.value <= 90 {
            sizeImage = "dumbbell3"
        }
        if lengthSlider.value >= 90 {
            sizeImage = "dumbbell4"
        }
        self.dumbbellIcon.image = UIImage(named: sizeImage)
        
        setupConstraints()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        let finalDurationValue = Int(lengthSlider.value)
//        NetworkManager.postExercise(username: "kj228", date: "26112019", update_to_duration: finalDurationValue)
//    }
//        


    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            exerciseLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.3),
            exerciseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            dumbbellIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dumbbellIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.bounds.height*0.03),
        ])
        
        NSLayoutConstraint.activate([
            lengthSlider.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.7),
            lengthSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.bounds.width)*0.1),
            lengthSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (view.bounds.width)*(-0.1)),
        ])
        
        NSLayoutConstraint.activate([
            lengthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lengthLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.65),
        ])
    }

    
    @objc func dismissViewControllerAndSaveText() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func goesBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func lengthChange() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//        dateFormatter.timeStyle = .none
//        let dateString = dateFormatter.string(from: Date())
//
//        NetworkManager.postSleep(username: "", date: dateString, update_to: Int(sleepSlider.value))
//        getSleep()
        let intEstimate = Int(lengthSlider.value)
        lengthLabel.text = "\(intEstimate)" + " minutes"
        
        var sizeImage = "dumbbell1"
        if lengthSlider.value <= 30 && lengthSlider.value >= 60 {
            sizeImage = "dumbbell2"
        }
        if lengthSlider.value >= 60 && lengthSlider.value <= 90 {
            sizeImage = "dumbbell3"
        }
        if lengthSlider.value >= 90 {
            sizeImage = "dumbbell4"
        }
        self.dumbbellIcon.image = UIImage(named: sizeImage)

    }
}

