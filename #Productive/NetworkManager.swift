//
//  NetworkManager.swift
//  #Productive
//
//  Created by Sohwi Jung on 12/5/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
 //   private static let backendURL = "http://0.0.0.0:5000"
    private static let backendURL = "http://34.73.135.191"

    
    static func initializeDatapoint(username: String, date: String) {
        let urlForInitialize = backendURL + "/api/get_data/"

        let parameters = [
            "username": username,
            "date": date,
            ] as [String : Any]
        Alamofire.request(urlForInitialize, method: .post, parameters: parameters).validate().responseData { response in
            switch response.result {

            case .success(let data):
                    print("blank")
  //              print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
    static func getData(username: String, date: String, _ didGetData: @escaping (UserData) -> Void) {
        let urlForGetData = backendURL + "/api/get_data/"
        let parameters: [String: Any] = [
            "username": username,
            "date": date
        ]
        Alamofire.request(urlForGetData, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {

            case .success(let data):
                let jsonDecoder = JSONDecoder()
                print("1")
                print(data)
                print(try? jsonDecoder.decode(UserDataResponse.self, from: data))
                if let UserDataRes = try? jsonDecoder.decode(UserDataResponse.self, from: data) {
                    print("2")
                    print(UserDataRes)
                    let UserData = UserDataRes.data
                    print("3")
                    print(UserData)
                    didGetData(UserData)
                } else {
                    print("Invalid respone data or whatever")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            }
    }
    
    static func getCorrelation(username: String, metric: String, _ didGetData: @escaping (correlationStruct) -> Void ){
        let urlForGetData = backendURL + "/api/corelation/?var1=Mood&var2=" + metric + "&username=" + username
        Alamofire.request(urlForGetData, method: .get, encoding: JSONEncoding.default).validate().responseData { response in
        switch response.result {

        case .success(let data):
            let jsonDecoder = JSONDecoder()
            print("1")
            print(data)
            print(try? jsonDecoder.decode(correlationMainStruct.self, from: data))
            if let UserDataRes = try? jsonDecoder.decode(correlationMainStruct.self, from: data) {
                print("2")
                print(UserDataRes)
                let UserData = UserDataRes.data
                print("3")
                print(UserData)
                didGetData(UserData)
            } else {
                print("Invalid respone data or whatever")
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
        }
        
    }
    
    static func loginUser(username: String, password: String, _ didGetData: @escaping (loginsignup) -> Void ){
        let urlForGetData = backendURL + "/api/login/"
        let parameters: [String: Any] = [
            "username": username,
            "password": String(password.hash)
        ]
        Alamofire.request(urlForGetData, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                print("1")
                print(data)
                print(try? jsonDecoder.decode(UserDataResponse.self, from: data))
                if let dataResponse = try? jsonDecoder.decode(loginsignup.self, from: data) {
                    didGetData(dataResponse)
                } else {
                    print("Invalid response data or whatever")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            }
    }
    
    static func signupUser(username: String, password: String, _ didGetData: @escaping (loginsignup) -> Void ){
        let urlForGetData = backendURL + "/api/signup/"
        let parameters: [String: Any] = [
            "username": username,
            "password": String(password.hash)
        ]
        Alamofire.request(urlForGetData, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                print("1")
                print(data)
                print(try? jsonDecoder.decode(UserDataResponse.self, from: data))
                if let dataResponse = try? jsonDecoder.decode(loginsignup.self, from: data) {
                    didGetData(dataResponse)
                } else {
                    print("Invalid response data or whatever")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            }
    }
    
    static func getAllData(username: String, _ didGetData: @escaping ([UserData]) -> Void ){
        print("BLOODY HELL THIS WORKS")
        let urlForGetData = backendURL + "/api/get_all_data/?username=" + username
//        let parameters: [String: Any] = [
//            "username": username
//        ]
        Alamofire.request(urlForGetData, method: .get, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {

            case .success(let data):
                let jsonDecoder = JSONDecoder()
//                print("1")
//                print(data)
//                print(try? jsonDecoder.decode(UserDataResponseComplete.self, from: data)) //FOUND IT
                if let UserDataRes = try? jsonDecoder.decode(UserDataResponseComplete.self, from: data) {
//                    print("2")
//                    print(UserDataRes)
                    let Data = UserDataRes.data
//                    print("3")
//                    print(UserData)
                    didGetData(Data)
                } else {
                    print("Invalid respone data or whatever")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            }
    }
    
//    static func getWater(username: String, date: String, _ didGetWater: @escaping (UserDataResponse) -> Void) {
//        let urlForGetWater = backendURL + "/api/get_data/water"
//        let parameters = [
//            "username": username,
//            "date": date
//        ]
//        Alamofire.request(urlForGetWater, method: .get, parameters: parameters).validate().responseData { response in
//            switch response.result {
//
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//
//                if let waterData = try? jsonDecoder.decode(UserDataResponse.self, from: data) {
//                didGetWater(waterData)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            }
//    }
//
//    static func getSleep(username: String, date: String, _ didGetSleep: @escaping (UserDataResponse) -> Void) {
//        let urlForGetSleep = backendURL + "/api/get_data/sleep"
//        let parameters = [
//            "username": username,
//            "date": date
//        ]
//        Alamofire.request(urlForGetSleep, method: .get, parameters: parameters).validate().responseData { response in
//            switch response.result {
//
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//
//                if let sleepData = try? jsonDecoder.decode(UserDataResponse.self, from: data) {
//                didGetSleep(sleepData)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            }
//    }
    
    static func postWater(username: String, date: String, update_by: Int){
        print("am i being called?")
        let urlForPostWater = backendURL + "/api/update_water/"
        let parameters = [
            "username": username,
            "date": date,
            "update_by": update_by
            ] as [String : Any]
        Alamofire.request(urlForPostWater, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {

            case .success(let data):
                print("blank")
   //             print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
            }
    }
    
    
    
    static func postSleep(username: String, date: String, update_to: Int){
        let urlForPostSleep = backendURL + "/api/update_sleep/"
        let parameters = [
            "username": username,
            "date": date,
            "update_to": update_to
            ] as [String : Any]
        Alamofire.request(urlForPostSleep, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {

            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
            }
    }
    
//    static func getMood(username: String, date: String, _ didGetMood: @escaping (Int) -> Void) {
//        let urlForGetMood = backendURL + "/api/get_data/mood"
//        let parameters = [
//            "username": username,
//            "date": date
//        ]
//        Alamofire.request(urlForGetMood, method: .get, parameters: parameters).validate().responseData { response in
//            switch response.result {
//
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//
//                if let moodData = try? jsonDecoder.decode(Int.self, from: data) {
//                didGetMood(moodData)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            }
//    }
    
    static func postMood(username: String, date: String, update_to: Int){
        let urlForPostMood = backendURL + "/api/update_mood/"
        let parameters = [
            "username": username,
            "date": date,
            "update_to": update_to
            ] as [String : Any]
        Alamofire.request(urlForPostMood, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {

            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
            }
    }
    
//    static func getExercise(username: String, date: String, _ didGetExercise: @escaping (Int) -> Void) {
//        let urlForGetExercise = backendURL + "/api/get_data/fitness"
//        let parameters = [
//            "username": username,
//            "date": date
//        ]
//        Alamofire.request(urlForGetExercise, method: .get, parameters: parameters).validate().responseData { response in
//            switch response.result {
//
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//
//                if let exerciseData = try? jsonDecoder.decode(Int.self, from: data) {
//                didGetExercise(exerciseData)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            }
//    }
    
    static func postExercise(username: String, date: String, update_to_duration: Int){
        let urlForPostExercise = backendURL + "/api/update_fitness/"
        let parameters = [
            "username": username,
            "date": date,
            "update_to_intensity": 0,
            "update_to_duration": update_to_duration
            ] as [String : Any]
        Alamofire.request(urlForPostExercise, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {

            case .success(let data):
               print("blank") //to be ignored
//                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
            }
    }
    
}
