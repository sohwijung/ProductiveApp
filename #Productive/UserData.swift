//
//  UserData.swift
//  #Productive
//
//  Created by Kushagra Jain on 12/7/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import Foundation

struct UserData: Codable {
    var date: String
    var username: String
    var water_data: Int
    var mood_data: Int
    var sleep_data: Int
    var fitness_data_intensity: Int
    var fitness_data_duration: Int
}

struct UserDataResponse: Codable{
    var success: Bool
    var data: UserData
}

struct loginsignup: Codable{
    var success: Bool
    var data: String
}

struct UserDataResponseComplete: Codable{
    var success: Bool
    var data: [UserData]
}

struct correlationMainStruct: Codable{
    var success: Bool
    var data: correlationStruct
}

struct correlationStruct: Codable{
    var var1: String
    var var2: String
    var intercept: Float
    var coef: Float
    var MAE: Float
    var MSE: Float
    var RMS: Float
}
