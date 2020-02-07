//
//  SleepViewController.swift
//  #Productive
//
//  Created by Sohwi Jung on 11/19/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import UIKit

class SleepViewController: UIViewController {

    var sleepLabel: UILabel!
    var sleepSlider: UISlider!
    var sleepSliderValue: UILabel!
    var moonIcon: UIImageView!
    var currentSleepValue: Int!
    
    var numberOfIncrements = 25

    weak var delegate: ReceiveInformation?
    
    init(sleepValue: Int){
        self.currentSleepValue = sleepValue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     override func viewDidDisappear(_ animated: Bool) {
        delegate?.sleepValueChanged(to: Int(sleepSlider.value))
        let finalSleepValue = Int(sleepSlider.value)
        NetworkManager.postSleep(username: userDefaults.string(forKey: "username")!, date: ViewController.currentDate, update_to: finalSleepValue)
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        sleepLabel = UILabel()
        sleepLabel.translatesAutoresizingMaskIntoConstraints = false
        sleepLabel.text = "Sleep"

        sleepLabel.textColor = .black
        sleepLabel.textAlignment = .center
        sleepLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(sleepLabel)
        
        sleepSlider = UISlider()
        sleepSlider.minimumValue = 0
        sleepSlider.maximumValue = 24
        sleepSlider.translatesAutoresizingMaskIntoConstraints = false
        sleepSlider.addTarget(self, action: #selector(valueChange), for: .touchDragInside)
        sleepSlider.tintColor = .purple
        view.addSubview(sleepSlider)
//        NetworkManager.getData(username: "kj228", date: ViewController.currentDate) { responseData in
//            var sleepValue = String(responseData.sleep_data)
//            self.sleepSlider.value = Float(sleepValue)!
//        }
        sleepSlider.value = Float(currentSleepValue!)
        
        sleepSliderValue = UILabel()
        sleepSliderValue.translatesAutoresizingMaskIntoConstraints = false
        sleepSliderValue.textColor = .gray
        sleepSliderValue.textAlignment = .center
        sleepSliderValue.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        sleepSliderValue.text = "\(currentSleepValue!)" + " hours"
        view.addSubview(sleepSliderValue)
        
        moonIcon = UIImageView()
        moonIcon.image = UIImage(named: "moon1")
        moonIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moonIcon)
        
        
        
        view.addSubview(sleepSlider)

        
        var sizeImage = "moon1"
        if currentSleepValue <= 3 && currentSleepValue >= 6 {
            sizeImage = "moon2"
        }
        if currentSleepValue >= 6 && currentSleepValue <= 9 {
            sizeImage = "moon3"
        }
        if currentSleepValue >= 9 {
            sizeImage = "moon4"
        }
        self.moonIcon.image = UIImage(named: sizeImage)
        
        setupConstraints()

    }
    
//
//    override func viewWillDisappear(_ animated: Bool) {
//        let finalSleepValue = Int(sleepSlider.value)
//        NetworkManager.postSleep(username: "kj228", date: "26112019", update_to: finalSleepValue)
//    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sleepLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.3),
            sleepLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            sleepSlider.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.7),
            sleepSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.bounds.width)*0.1),
            sleepSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (view.bounds.width)*(-0.1)),
        ])
        
        NSLayoutConstraint.activate([
            sleepSliderValue.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sleepSliderValue.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.65),
        ])
        
        NSLayoutConstraint.activate([
            moonIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moonIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.bounds.height*0.03)
        ])
        
     
    }

    @objc func dismissViewControllerAndSaveText() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func goesBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func valueChange() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//        dateFormatter.timeStyle = .none
//        let dateString = dateFormatter.string(from: Date())
//
//        NetworkManager.postSleep(username: "", date: dateString, update_to: Int(sleepSlider.value))
//        getSleep()
        let intEstimate = Int(sleepSlider.value)
        sleepSliderValue.text = "\(intEstimate)" + " hours"
        
        var sizeImage = "moon1"
        if sleepSlider.value <= 3 && sleepSlider.value >= 6 {
            sizeImage = "moon2"
        }
        if sleepSlider.value >= 6 && sleepSlider.value <= 9 {
            sizeImage = "moon3"
        }
        if sleepSlider.value >= 9 {
            sizeImage = "moon4"
        }
        self.moonIcon.image = UIImage(named: sizeImage)
    }
}
    
//    @objc func getSleep() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//        dateFormatter.timeStyle = .none
//        let dateString = dateFormatter.string(from: Date())
//
//        NetworkManager.getSleep(username: "", date: dateString) { (getSleepValue) in
//            self.sleepSliderValue.text = "\(getSleepValue)"
//        }
//    }
    
    

