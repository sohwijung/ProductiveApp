//
//  WaterViewController.swift
//  #Productive
//
//  Created by Sohwi Jung on 11/19/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import UIKit

struct Stack {
    private var myArray: [Int] = []
    
    mutating func push(_ element: Int) {
        myArray.append(element)
    }
    
    mutating func pop() -> Int? {
        guard let topElement = myArray.popLast() else {return 0}
        return topElement
    }

}

class WaterViewController: UIViewController {
    
    var waterLabel: UILabel!
    var oneCup: UIButton!
    var oneBottle: UIButton!
    var onehundredml: UIButton!
    var oneCupValue: Int!
    var oneBottleValue: Int!
    var onehundredmlValue: Int!
    var currentWater: Int!
    var currentWaterText: UILabel!
    var dropIcon: UIImageView!
    var undoButton: UIButton!
    var stack: Stack!
    var reachedLimit: UILabel!
    
    weak var delegate: ReceiveInformation?
    
    init(waterLevel: Int){
        self.currentWater = waterLevel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// two functions, one where if onecup pressed, add oneupvalue to currentwater
// one where when currentWAter >= waterGoal, animation
// when onecup pressed img grows by two, onebottle by 5, oneliter by 10, there will be 20
    
    override func viewDidDisappear(_ animated: Bool) {

        delegate?.waterValueChanged(to: currentWater)
    }
    
    override func viewDidLoad() {
        stack = Stack()
        super.viewDidLoad()
        view.backgroundColor = .white
        
        reachedLimit = UILabel()
        reachedLimit.text = ""
        reachedLimit.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reachedLimit)
        reachedLimit.textColor = .gray
        
        currentWaterText = UILabel()
        currentWaterText.textColor = .gray
        currentWaterText.textAlignment = .center
        currentWaterText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        currentWaterText.text =  "\(currentWater!) ml"
        currentWaterText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentWaterText)
        
        waterLabel = UILabel()
        waterLabel.translatesAutoresizingMaskIntoConstraints = false
        waterLabel.text = "Water"
//        var waterValue = "default"
//        NetworkManager.getData(username: "kj228", date: "26112019") { responseData in
//            waterValue = String(responseData.water_data)
//            self.currentWater = Int(waterValue)!
//        }
        waterLabel.textColor = .black
        waterLabel.textAlignment = .center
        waterLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(waterLabel)
        
        oneCup = UIButton()
        oneCup.translatesAutoresizingMaskIntoConstraints = false
        oneCup.setTitle("One cup", for: .normal)
        oneCup.addTarget(self, action: #selector(addWater), for: .touchUpInside)
        oneCup.setTitleColor(.black, for: .normal)
        view.addSubview(oneCup)
        
        undoButton = UIButton()
           undoButton.translatesAutoresizingMaskIntoConstraints = false
           undoButton.setTitle("Undo", for: .normal)
           undoButton.addTarget(self, action: #selector(addWater), for: .touchUpInside)
           undoButton.setTitleColor(.darkGray, for: .normal)
           view.addSubview(undoButton)
        
        oneBottle = UIButton()
        oneBottle.translatesAutoresizingMaskIntoConstraints = false
        oneBottle.setTitle("One bottle", for: .normal)
        oneBottle.setTitleColor(.black, for: .normal)
        oneBottle.addTarget(self, action: #selector(addWater), for: .touchUpInside)
        view.addSubview(oneBottle)
        
        onehundredml = UIButton()
        onehundredml.translatesAutoresizingMaskIntoConstraints = false
        onehundredml.setTitle("100 ml", for: .normal)
        onehundredml.setTitleColor(.black, for: .normal)
        onehundredml.addTarget(self, action: #selector(addWater), for: .touchUpInside)
        view.addSubview(onehundredml)
        
  //      currentWater = 0
        
        oneCupValue = 200
        oneBottleValue = 500
        onehundredmlValue = 100

       //currentWater = 0
        

        
        dropIcon = UIImageView()
        dropIcon.image = UIImage(named: "drop1")
        dropIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dropIcon)

        
        //Setting the size of the droplet in the viewDidLoad method is difficult to do as the getdata function is asynchronous
        //this means that it takes some time for the server to respond and other code below it is executed during that delay
        //So later have the water value passed from the home screen to the water screen and use that

        //For now:
        var sizeImage = "drop1"
        if currentWater <= 1000 && currentWater >= 500 {
            sizeImage = "drop2"
        }
        if currentWater >= 1000 && currentWater <= 2000 {
            sizeImage = "drop3"
        }
        if currentWater >= 2000 {
            sizeImage = "drop4"
        }
        if currentWater >= 3000{
            sizeImage = "drop5"
            reachedLimit.text = "Reached daily recommended water intake!"
        }
        
        self.dropIcon.image = UIImage(named: sizeImage)
        
        setupConstraints()
    }
    
    @objc func addWater() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//        dateFormatter.timeStyle = .none
//        let dateString = dateFormatter.string(from: Date())

        currentWaterText.text = ""
        if oneCup.isTouchInside == true {
            currentWater = currentWater + oneCupValue
            currentWaterText.text = "\(currentWater ?? 0)" + " ml"
            print("reached here")
            NetworkManager.postWater(username: userDefaults.string(forKey: "username")!, date: ViewController.currentDate, update_by: oneCupValue)
            stack.push(oneCupValue)
        }
        if oneBottle.isTouchInside == true {
            currentWater = currentWater + oneBottleValue
            currentWaterText.text = "\(currentWater ?? 0)" + " ml"
            NetworkManager.postWater(username: userDefaults.string(forKey: "username")!, date: ViewController.currentDate, update_by: oneBottleValue)
            stack.push(oneBottleValue)
        }
        if undoButton.isTouchInside == true{
            let undoValue = stack.pop()
            currentWater = currentWater - undoValue!
            currentWaterText.text = "\(currentWater ?? 0)" + " ml"
            NetworkManager.postWater(username: userDefaults.string(forKey: "username")!, date: ViewController.currentDate, update_by: -undoValue!)
        }
        if onehundredml.isTouchInside == true {
            currentWater = currentWater + onehundredmlValue
            currentWaterText.text = "\(currentWater ?? 0)" + " ml"
            NetworkManager.postWater(username: userDefaults.string(forKey: "username")!, date: ViewController.currentDate, update_by: onehundredmlValue)
            stack.push(onehundredmlValue)
        }
        var sizeImage = "drop1"
        if currentWater <= 1000 && currentWater >= 500 {
            sizeImage = "drop2"
        }
        if currentWater >= 1000 && currentWater <= 2000 {
            sizeImage = "drop3"
        }
        if currentWater >= 2000 {
            sizeImage = "drop4"
        }
        if currentWater >= 3000 {
            sizeImage = "drop5"
            reachedLimit.text = "Reached daily recommended water intake"
        }
        
        self.dropIcon.image = UIImage(named: sizeImage)
//        getWater()
    }
    
//    @objc func getWater() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//        dateFormatter.timeStyle = .none
//        let dateString = dateFormatter.string(from: Date())
//
//        NetworkManager.getWater(username: "", date: dateString) { (getWaterValue) in
//            self.currentWaterText.text = "\(getWaterValue)"
//            var sizeImage = "drop1"
//            if getWaterValue >= 1000 && getWaterValue <= 2000 {
//                sizeImage = "drop2"
//            }
//            if getWaterValue >= 2000 {
//                sizeImage = "drop3"
//            }
//            self.dropIcon.image = UIImage(named: sizeImage)
//        }
//    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            waterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.3),
            waterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            oneCup.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.7),
            oneCup.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.bounds.width)*0.1),
        ])
        NSLayoutConstraint.activate([
            oneBottle.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.7),
            oneBottle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            onehundredml.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.7),
            onehundredml.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (view.bounds.width)*(-0.1)),
        ])
        NSLayoutConstraint.activate([
            currentWaterText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWaterText.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.65),
        ])
        NSLayoutConstraint.activate([
            currentWaterText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWaterText.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.6),
        ])
        NSLayoutConstraint.activate([
            dropIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dropIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.bounds.height*0.03)
        ])
        NSLayoutConstraint.activate([
                  undoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                  undoButton.topAnchor.constraint(equalTo: oneBottle.bottomAnchor, constant: (view.bounds.height)*0.03),
              ])
        
        NSLayoutConstraint.activate([
            reachedLimit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reachedLimit.topAnchor.constraint(equalTo: undoButton.bottomAnchor, constant: (view.bounds.height)*0.05),
        ])
        
    }


    
    @objc func dismissViewControllerAndSaveText() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func goesBack() {
        dismiss(animated: true, completion: nil)
    }
    


}
