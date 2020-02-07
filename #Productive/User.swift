//
//  User.swift
//  #Productive
//
//  Created by Sohwi Jung on 12/5/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import UIKit

import Foundation

class User{
    var water: Int
    var exercise: Int
    var mood: Int
    var sleep: Int
    var date: String
    
    init(water: Int, exercise: Int, mood: Int, sleep: Int, date: String) {
        self.water = water
        self.exercise = exercise
        self.mood = mood
        self.sleep = sleep
        self.date = date
    }
}
