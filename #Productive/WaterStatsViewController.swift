
//
//  WaterStatsViewController.swift
//  #Productive
//
//  Created by Kushagra Jain on 12/23/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//


import Foundation
import UIKit
import CareKit

class WaterStatsViewController: UIViewController{
        var someText: UITextView!
        var chartView: OCKCartesianChartView!
        var data: [CGPoint]! = []
        var minX: Int = 10000
        var maxX: Int = -1
        var minY: Int = 10000
        var maxY: Int = -1
        var titleText: UILabel!
        var averageY: Double = 0.0
        var noOfDataPoints: Int = 0
        
        override func viewDidLoad() {
            var flag = 0
            view.backgroundColor = .white
            someText = UITextView()
            someText.translatesAutoresizingMaskIntoConstraints = false
            someText.font = UIFont.systemFont(ofSize: 16.0)
            someText.textAlignment = .center
            view.addSubview(someText)
            
            titleText = UILabel()
            titleText.translatesAutoresizingMaskIntoConstraints = false
            titleText.text = "Mood vs. Water"
            titleText.font = UIFont.boldSystemFont(ofSize: 20.0)
            view.addSubview(titleText)
            
            
            NetworkManager.getAllData(username: userDefaults.string(forKey: "username")!) { (responseData) in
                var sum = 0.0
                var count = 0.0
                var differentXValues: [Int] = []
                for element in responseData{
                    if (element.mood_data > 0){
                        if !differentXValues.contains(element.water_data){
                            differentXValues.append(element.water_data)
                        }
                    sum = sum + Double(element.water_data)
                    count = count + 1.0
                    if (Int(element.water_data) < self.minX){
                        self.minX = Int(element.water_data)
                    }
                    if (Int(element.water_data) > self.maxX){
                        self.maxX = Int(element.water_data)
                    }
                     self.data.append(CGPoint(x: Int(element.water_data), y: Int(element.mood_data)))
                    }
                }
                print("\(sum) and \(count)")
                self.averageY = sum/count
                self.noOfDataPoints = differentXValues.count
                if (self.noOfDataPoints < 2){
                    self.someText.text = "Insufficient data"
                }
                flag = 1
            }
            NetworkManager.getCorrelation(username: userDefaults.string(forKey: "username")!, metric: "Water") { (correlationStruct) in
                
                var strength = "blank"
                if (Double(correlationStruct.RMS)>(0.45*self.averageY)){
                     strength = "very weak"
                }else if (Double(correlationStruct.RMS)>(0.3*self.averageY)){
                     strength = "weak"
                }else if (Double(correlationStruct.RMS)>(0.2*self.averageY)){
                     strength = "strong"
                }else {strength = "very strong"}
                
                var sign = "blank"
                if (correlationStruct.coef < 0){
                    sign = "negative"
                }else{
                    sign = "positive"
                }
                
                self.someText.text = "There is a \(strength) \(sign) corelation between water intake and mood."
                
                if (correlationStruct.coef == 0){
                    self.someText.text = "No corelation"
                }
                if flag == 1{
                    if (self.noOfDataPoints < 2){
                        self.someText.text = "Insufficient data"
                    }
                }
            }
            chartView = OCKCartesianChartView(type: .scatter)
            chartView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(chartView)
            setupConstraints()
            chartView.graphView.yMinimum = 1
            chartView.graphView.yMaximum = 5
            chartView.graphView.dataSeries = [
                OCKDataSeries(dataPoints: data, title: "", size: 2, color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.5))
                    ]
            perform(#selector(setupGraph), with: nil, afterDelay: 1)

        }
        
        @objc func setupGraph(){
            print(data!)
                    chartView.graphView.dataSeries = [
                        OCKDataSeries(dataPoints: data!, title: "", size: 2, color: UIColor(red: 0, green: 0, blue: 0, alpha: 100))
                    ]

            var horizontalAxis: [String] = []
            if minX == 10000 {
                print("why is minx still this")
                minX = 0
            }
            if maxX == -1{
                print("why is maxX still this")
                maxX = 0
            }
            let spacing = Double((maxX - minX))/5.0
            horizontalAxis.append("\(String(format: "%.0f", Double(minX)))ml")
            for i in 1...5{
               horizontalAxis.append("\(String(format: "%.0f", (0.000000001 + Double(minX) + (Double(i)*spacing))))ml")
            }
    //
    //        for i in minX/10...maxX/10 {
    //            print(i)
    //            horizontalAxis.append(String(i*10))
    //        }
            chartView.graphView.horizontalAxisMarkers = horizontalAxis
            chartView.graphView.yMinimum = 1
            chartView.graphView.yMaximum = 5
            print("Average is \(averageY)")
            
            setupConstraints()
        }
        
        
        func setupConstraints(){
            print("this is \(view.bounds.height)")
            NSLayoutConstraint.activate([
                titleText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.037*view.bounds.height),
                       titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.03*view.bounds.height)
                   ])
            NSLayoutConstraint.activate([
                chartView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 0.037*view.bounds.height),
                chartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                chartView.heightAnchor.constraint(equalToConstant: view.bounds.height/2),
     //           chartView.heightAnchor.constraint(equalTo: view.heightAnchor2)
                chartView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.97)
            ])
            NSLayoutConstraint.activate([
                 someText.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 0.05*view.bounds.height),
                 someText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                 someText.widthAnchor.constraint(equalToConstant: view.bounds.width*0.9),
                 someText.heightAnchor.constraint(equalToConstant: 100)
             ])
            NSLayoutConstraint.activate([
    //            chartView.graphView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    //            chartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                chartView.graphView.heightAnchor.constraint(equalToConstant: (view.bounds.height/2)),
            //     chartView.heightAnchor.constraint(equalTo: view.heightAnchor2)
                chartView.graphView.widthAnchor.constraint(equalTo: view.widthAnchor),
                //chartView.graphView.centerYAnchor.constraint(equalTo: chartView.centerYAnchor, constant: -(chartView.graphView.bounds.height*1.8/8))
                   ])
            
        }
    }
