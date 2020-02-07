//
//  StatsMainViewController.swift
//  #Productive
//
//  Created by Kushagra Jain on 12/23/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import Foundation
import UIKit
import CareKit

class StatsMainViewController: UIViewController {
    var buttonForExercise: UIButton!
    var buttonForWater: UIButton!
    var buttonForSleep: UIButton!
    var waterText: UILabel!
    var exerciseText: UILabel!
    var sleepText: UILabel!
    
    
    override func viewDidLoad(){
        view.backgroundColor = .white
        title = "Statistics"
        
        waterText = UILabel()
        waterText.translatesAutoresizingMaskIntoConstraints = false
        waterText.text = "Water Intake"
        view.addSubview(waterText)
        
        exerciseText = UILabel()
        exerciseText.translatesAutoresizingMaskIntoConstraints = false
        exerciseText.text = "Exercise Duration"
        view.addSubview(exerciseText)
        
        sleepText = UILabel()
        sleepText.translatesAutoresizingMaskIntoConstraints = false
        sleepText.text = "Daily Sleep"
        view.addSubview(sleepText)
        
        buttonForWater = UIButton()
        buttonForWater.translatesAutoresizingMaskIntoConstraints = false
        let waterImage = UIImage(named: "drop")
        buttonForWater.setImage(waterImage, for: UIControl.State.normal)
        buttonForWater.addTarget(self, action: #selector(WaterStats), for: .touchUpInside)
        view.addSubview(buttonForWater)
        
        buttonForExercise = UIButton()
        buttonForExercise.translatesAutoresizingMaskIntoConstraints = false
        let excerciseImage = UIImage(named: "dumbbell")
        buttonForExercise.setImage(excerciseImage, for: UIControl.State.normal)
        buttonForExercise.addTarget(self, action: #selector(ExerciseStats), for: .touchUpInside)
        view.addSubview(buttonForExercise)
        
        buttonForSleep = UIButton()
        buttonForSleep.translatesAutoresizingMaskIntoConstraints = false
        let sleepImage = UIImage(named: "moon")
        buttonForSleep.setImage(sleepImage, for: UIControl.State.normal)
        buttonForSleep.addTarget(self, action: #selector(SleepStats), for: .touchUpInside)
        view.addSubview(buttonForSleep)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            buttonForWater.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonForWater.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.22)
        ])
        
        NSLayoutConstraint.activate([
            waterText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waterText.topAnchor.constraint(equalTo: buttonForWater.bottomAnchor, constant: (view.bounds.height)*0.023)
        ])
        
        NSLayoutConstraint.activate([
            exerciseText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exerciseText.topAnchor.constraint(equalTo: buttonForExercise.bottomAnchor, constant: (view.bounds.height)*0.01)
        ])
        
        
        NSLayoutConstraint.activate([
            sleepText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sleepText.topAnchor.constraint(equalTo: buttonForSleep.bottomAnchor, constant: (view.bounds.height)*0.022)
        ])

        NSLayoutConstraint.activate([
            buttonForSleep.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonForSleep.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.47)
        ])
        
        NSLayoutConstraint.activate([
            buttonForExercise.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonForExercise.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.72)
        ])
    }

    
    @objc func WaterStats(){
        let viewController = WaterStatsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func ExerciseStats(){
        let viewController = ExerciseStatsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func SleepStats(){
        let viewController = SleepStatsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func recentHistoryVisualised(){
        let storeManager: OCKSynchronizedStoreManager
        let store = OCKStore(name: "carekit-catalog")
        storeManager =  .init(wrapping: store)
        let chartViewController = makeChartViewController(withStyle: OCKCartesianGraphView.PlotType.scatter,
                                                          storeManager: storeManager)
        let listController = OCKListViewController()
        listController.appendViewController(chartViewController, animated: false)
        let viewController = listController
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func makeChartViewController(withStyle style: OCKCartesianGraphView.PlotType,
                                         storeManager: OCKSynchronizedStoreManager) -> UIViewController {
        let gradientStart = UIColor { traitCollection -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9960784314, green: 0.3725490196, blue: 0.368627451, alpha: 1) : #colorLiteral(red: 0.8627432641, green: 0.2630574384, blue: 0.2592858295, alpha: 1)
        }
        let gradientEnd = UIColor { traitCollection -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9960784314, green: 0.4732026144, blue: 0.368627451, alpha: 1) : #colorLiteral(red: 0.8627432641, green: 0.3598620686, blue: 0.2592858295, alpha: 1)
        }

        let markerSize: CGFloat = style == .bar ? 10 : 2
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let configurations = [
            OCKDataSeriesConfiguration(
                taskID: "doxylamine",
                legendTitle: "doxylamine",
                gradientStartColor: gradientStart,
                gradientEndColor: gradientEnd,
                markerSize: markerSize,
                eventAggregator: .countOutcomeValues)
        ]

        let chartViewController = OCKCartesianChartViewController(plotType: style, selectedDate: startOfDay,
                                                                  configurations: configurations, storeManager: storeManager)
        chartViewController.controller.fetchAndObserveInsights(forConfigurations: configurations)
        chartViewController.chartView.headerView.titleLabel.text = "doxylamine"
        return chartViewController
    }
    
}
