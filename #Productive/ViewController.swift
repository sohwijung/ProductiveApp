//
//  ViewController.swift
//  #Productive
//
//  Created by Sohwi Jung on 11/19/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import UIKit


protocol ReceiveInformation: class {
    func waterValueChanged(to newValue: Int)
    func moodValueChanged(to newValue: Int)
    func sleepValueChanged(to newValue: Int)
    func exerciseValueChanged(to newValue: Int)
}

//protocol SaveValue: class {
//    func saveWater(to newString: String)
//    func saveExercise(to newString: String)
//    func saveSleep(to newString: String)
//    func saveMood(to newString: String)
//}

class ViewController: UIViewController {
    
    static var currentDate: String = "default"
    var productivityPackLogo: UIImageView!
    var buttonForWater: UIButton!
    var buttonForExercise: UIButton!
    var buttonForSleep: UIButton!
    var buttonForMood: UIButton!
    var historyTab: UIButton!
    var statsTab: UIButton!
    var waterLabel: UILabel!
    var exerciseLabel: UILabel!
    var sleepLabel: UILabel!
    var moodLabel: UILabel!
    var logoutButton: UIButton!
    
    var currentWaterLevel: Int = 0
    var currentSleepLevel: Int = 0
    var currentExerciseLevel: Float = 0.0

    override func viewDidLoad() {
        //call function to set currentDate variable to current date as soon as app first loads
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        ViewController.currentDate = result
        
        logoutButton = UIButton()
         logoutButton.translatesAutoresizingMaskIntoConstraints = false
         logoutButton.setTitle("Logout \(userDefaults.string(forKey: "username")!)", for: .normal)
        logoutButton.setTitleColor(.blue, for: .normal)
         logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        logoutButton.setTitleColor(.link, for: .normal)
         view.addSubview(logoutButton)
        
        
        view.backgroundColor = .white
        
        productivityPackLogo = UIImageView()
        productivityPackLogo.image = UIImage(named: "logo")
        productivityPackLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productivityPackLogo)
        
        waterLabel = UILabel()
        waterLabel.translatesAutoresizingMaskIntoConstraints = false
//        NetworkManager.getData(username: "kj228", date: "26112019") { responseData in
//        self.waterLabel.text = "\(responseData.water_data) ml"
//        }
        waterLabel.textAlignment = .center
        view.addSubview(waterLabel)
        
        exerciseLabel = UILabel()
        exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
//        NetworkManager.getData(username: "kj228", date: "26112019") { responseData in
//        self.exerciseLabel.text = "\(responseData.fitness_data_duration) minutes"
//        }
        exerciseLabel.textAlignment = .center
        view.addSubview(exerciseLabel)
        
        sleepLabel = UILabel()
        sleepLabel.translatesAutoresizingMaskIntoConstraints = false
//        NetworkManager.getData(username: "kj228", date: "26112019") { responseData in
//        self.sleepLabel.text = "\(responseData.sleep_data) hours"
//        }
        sleepLabel.textAlignment = .center
        view.addSubview(sleepLabel)
        
        moodLabel = UILabel()
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        moodLabel.text = "Mood"
        moodLabel.textAlignment = .center
        view.addSubview(moodLabel)
        
        buttonForWater = UIButton()
        buttonForWater.translatesAutoresizingMaskIntoConstraints = false
        let waterImage = UIImage(named: "drop")
        buttonForWater.setImage(waterImage, for: UIControl.State.normal)
        buttonForWater.addTarget(self, action: #selector(WaterScreen), for: .touchUpInside)
        view.addSubview(buttonForWater)
        
        buttonForExercise = UIButton()
        buttonForExercise.translatesAutoresizingMaskIntoConstraints = false
        let exerciseImage = UIImage(named: "dumbbell")
        buttonForExercise.setImage(exerciseImage, for: UIControl.State.normal)
        buttonForExercise.addTarget(self, action: #selector(ExerciseScreen), for: .touchUpInside)
        view.addSubview(buttonForExercise)
        
        buttonForSleep = UIButton()
        buttonForSleep.translatesAutoresizingMaskIntoConstraints = false
        let sleepImage = UIImage(named: "moon")
        buttonForSleep.setImage(sleepImage, for: UIControl.State.normal)
        buttonForSleep.addTarget(self, action: #selector(SleepScreen), for: .touchUpInside)
        view.addSubview(buttonForSleep)
        
        buttonForMood = UIButton()
        buttonForMood.translatesAutoresizingMaskIntoConstraints = false
        var moodImage = UIImage(named: "like")
        
        
        NetworkManager.getData(username: userDefaults.string(forKey: "username")!, date: ViewController.currentDate) { responseData in
        let currentMood = responseData.mood_data
        switch currentMood {
            case 1:
                 moodImage = UIImage(named: "Miserable")
            case 2:
                 moodImage = UIImage(named: "Dull")
            case 3:
                 moodImage = UIImage(named: "Fine")
            case 4:
                 moodImage = UIImage(named: "Well")
            case 5:
                moodImage = UIImage(named: "Cheerful")
            default:
                 moodImage = UIImage(named: "like")
            }
            self.buttonForMood.setImage(moodImage, for: UIControl.State.normal)
        self.waterLabel.text = "\(responseData.water_data) ml"
        self.exerciseLabel.text = "\(responseData.fitness_data_duration) minutes"
        self.sleepLabel.text = "\(responseData.sleep_data) hours"
            self.currentSleepLevel = Int(responseData.sleep_data )
            self.currentWaterLevel = Int(responseData.water_data )
            self.currentExerciseLevel = Float(responseData.fitness_data_duration )
            
        }
        
        buttonForMood.addTarget(self, action: #selector(MoodScreen), for: .touchUpInside)
        view.addSubview(buttonForMood)
        
        
        historyTab = UIButton()
        let historyImage = UIImage(named: "history")
        historyTab.setBackgroundImage(historyImage, for: UIControl.State.normal)
        historyTab.addTarget(self, action: #selector(HistoryScreen), for: UIControl.Event.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: historyTab)
        
        statsTab = UIButton()
        let statsImage = UIImage(named: "stats")
        statsTab.setBackgroundImage(statsImage, for: UIControl.State.normal)
        statsTab.addTarget(self, action: #selector(StatsScreen), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: statsTab)
        
        setupConstraints()
    }
    
    @objc func logout(){
        userDefaults.setValue("default-blank-username", forKey: "username")
        let viewController = SetUsernameViewController()
    //    self.navigationController?.pushViewController(viewController, animated: true)
    //    self.navigationController?.popToViewController(viewController, animated: true)
        self.navigationController?.setViewControllers([viewController], animated: true)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonForWater.leftAnchor.constraint(equalTo: view.leftAnchor, constant: (view.bounds.width)*0.2),
            buttonForWater.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.48),
        ])
        NSLayoutConstraint.activate([
            buttonForExercise.rightAnchor.constraint(equalTo: view.rightAnchor, constant: (view.bounds.width)*(-0.2)),
            buttonForExercise.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.48),
        ])
        NSLayoutConstraint.activate([
            buttonForSleep.leftAnchor.constraint(equalTo: view.leftAnchor, constant: (view.bounds.width)*0.2),
            buttonForSleep.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.7),
        ])
        
        NSLayoutConstraint.activate([
                   logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
                   logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 17),
               ])
        NSLayoutConstraint.activate([
            buttonForMood.rightAnchor.constraint(equalTo: view.rightAnchor, constant: (view.bounds.width)*(-0.2)),
            buttonForMood.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.7),
            buttonForMood.widthAnchor.constraint(equalTo: buttonForExercise.widthAnchor),
            buttonForMood.heightAnchor.constraint(equalTo: buttonForSleep.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            productivityPackLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.22),
            productivityPackLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            waterLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: (view.bounds.width)*0.2),
            waterLabel.topAnchor.constraint(equalTo: buttonForWater.bottomAnchor, constant: 10),
            waterLabel.widthAnchor.constraint(equalTo: buttonForWater.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            moodLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: (view.bounds.width)*(-0.2)),
            moodLabel.topAnchor.constraint(equalTo: buttonForMood.bottomAnchor, constant: 10),
            moodLabel.widthAnchor.constraint(equalTo: buttonForMood.widthAnchor)
        ])
        
//        NSLayoutConstraint.activate([
//            statsTab.heightAnchor.constraint(equalToConstant: historyTab.bounds.height),
//            statsTab.widthAnchor.constraint(equalToConstant:  historyTab.bounds.height),
//            (statsTab.imageView?.widthAnchor.constraint(equalToConstant:  historyTab.bounds.height))!,
//            (statsTab.imageView?.heightAnchor.constraint(equalToConstant:  historyTab.bounds.height))!
//        ])
        
        NSLayoutConstraint.activate([
            sleepLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: (view.bounds.width)*0.2),
            sleepLabel.topAnchor.constraint(equalTo: buttonForSleep.bottomAnchor, constant: 10),
            sleepLabel.widthAnchor.constraint(equalTo: buttonForSleep.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            exerciseLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: (view.bounds.width)*(-0.2)),
            exerciseLabel.topAnchor.constraint(equalTo: buttonForExercise.bottomAnchor, constant: 10),
            exerciseLabel.widthAnchor.constraint(equalTo: buttonForExercise.widthAnchor)
        ])
        

    }
    
    @objc func WaterScreen() {
        let viewController = WaterViewController(waterLevel: currentWaterLevel)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func ExerciseScreen() {
        let viewController = ExerciseViewController(duration: self.currentExerciseLevel)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func SleepScreen() {
        let viewController = SleepViewController(sleepValue: currentSleepLevel)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func MoodScreen() {
        let viewController = MoodViewController()
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func HistoryScreen() {
        let viewController = HistoryViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func StatsScreen(){
        let viewController = StatsMainViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
              
}
//
//extension ViewController:
//SaveValue {
//    func saveWater(to newString: String) {
//        WaterViewController.setTitle(newString, for: .normal)
//    }
//}

extension ViewController: ReceiveInformation {
    
    func waterValueChanged(to newValue: Int) {
        self.currentWaterLevel = newValue
        self.waterLabel.text = "\(newValue) ml"
    }
    
    func moodValueChanged(to newValue: Int) {

        print("do take note of this \(newValue)")
        var moodImage = UIImage(named: "like")
        switch newValue {
                   case 1:
                        moodImage = UIImage(named: "Miserable")
                   case 2:
                        moodImage = UIImage(named: "Dull")
                   case 3:
                        moodImage = UIImage(named: "Fine")
                   case 4:
                        moodImage = UIImage(named: "Well")
                   case 5:
                       moodImage = UIImage(named: "Cheerful")
                   default:
                        moodImage = UIImage(named: "like")
                   }
        self.buttonForMood.setImage(moodImage, for: UIControl.State.normal)
    }
    
    func sleepValueChanged(to newValue: Int) {
        self.sleepLabel.text = "\(newValue) hours"
        self.currentSleepLevel = newValue
    }
    
    func exerciseValueChanged(to newValue: Int) {
        self.exerciseLabel.text = "\(newValue) minutes"
        self.currentExerciseLevel = Float(newValue)
    }
    
}
