//
//  SetUsernameViewController.swift
//  #Productive
//
//  Created by Kushagra Jain on 12/23/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import Foundation
import UIKit

class SetUsernameViewController: UIViewController, UITextFieldDelegate {
    var textBox: UITextField!
    var label: UILabel!
    var loginLabel: UILabel!
    var signUpButton: UIButton!
    var loginButton: UIButton!
    var enterUsername: UILabel!
    var passwordTextBox: UITextField!
    var enterPassword: UILabel!
    
    override func viewDidLoad() {

        view.backgroundColor = .white
        
        textBox = UITextField()
        textBox.translatesAutoresizingMaskIntoConstraints = false
//        textBox.text = "kj228"
        textBox.autocapitalizationType = .none
        textBox.autocorrectionType = .no
        textBox.borderStyle = .roundedRect
        view.addSubview(textBox)
        textBox.delegate = self
        textBox.returnKeyType = .done
        
                passwordTextBox = UITextField()
                passwordTextBox.translatesAutoresizingMaskIntoConstraints = false
                passwordTextBox.autocapitalizationType = .none
                passwordTextBox.autocorrectionType = .no
                passwordTextBox.borderStyle = .roundedRect
        passwordTextBox.isSecureTextEntry = true
                view.addSubview(passwordTextBox)
                passwordTextBox.delegate = self
                passwordTextBox.returnKeyType = .done
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .systemRed
        view.addSubview(label)
        
        enterUsername = UILabel()
        enterUsername.translatesAutoresizingMaskIntoConstraints = false
        enterUsername.text = "Enter username: "
        enterUsername.textColor = .gray
        view.addSubview(enterUsername)
        
        enterPassword = UILabel()
        enterPassword.translatesAutoresizingMaskIntoConstraints = false
        enterPassword.text = "Enter password: "
        enterPassword.textColor = .gray
        view.addSubview(enterPassword)
        
        loginLabel = UILabel()
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Login/Sign Up"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 45.0)
        loginLabel.textColor = .darkGray
        view.addSubview(loginLabel)
        
        signUpButton = UIButton()
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(checkUsernameUnique), for: UIControl.Event.touchUpInside)
        signUpButton.setTitle("  Sign Up  ", for: UIControl.State.normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        signUpButton.backgroundColor = .gray
        view.addSubview(signUpButton)
        
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(setUsernameVariable), for: UIControl.Event.touchUpInside)
        loginButton.setTitle("  Login  ", for: UIControl.State.normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.backgroundColor = .gray
        view.addSubview(loginButton)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            textBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textBox.topAnchor.constraint(equalTo: enterUsername.bottomAnchor, constant: (view.bounds.height)*0.0213)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextBox.topAnchor.constraint(equalTo: enterPassword.bottomAnchor, constant: (view.bounds.height)*0.0213)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.71)
        ])
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.61),
        ])
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height)*0.8)
        ])

        NSLayoutConstraint.activate([
            enterUsername.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            enterUsername.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: (view.bounds.height)*0.065)
        ])
        
        NSLayoutConstraint.activate([
            enterPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            enterPassword.topAnchor.constraint(equalTo: textBox.bottomAnchor, constant: (view.bounds.height)*0.03)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.bounds.height)*0.08)
        ])

        
    }
    
//    @objc func checkUsernameUnique(){
//        let text = textBox.text ?? "error"
//
//
//        NetworkManager.getAllData(username: text) { responseData in
//
//            if (responseData.isEmpty){
//                userDefaults.setValue(text, forKey: "username")
//                let viewController = ViewController()
//                self.navigationController?.pushViewController(viewController, animated: true)
//            }else {
//                self.label.text = "Username already taken!"
//            }
//        }
//
//
//
//    }
    
    
    @objc func checkUsernameUnique(){
        let username = textBox.text ?? ""
        let password = passwordTextBox.text ?? ""
        let usernameTrimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if usernameTrimmed == ""{
            self.label.text = "Please enter a value in the username field"
        }else{
            if password == ""{
                self.label.text = "Please enter a value in the password field"
            }else{
                if (password.count<6){
                    self.label.text = "Password must be at least 6 characters"
                }else{
                     self.label.text = ""
                     
                     //
                     
                     NetworkManager.signupUser(username: usernameTrimmed, password: password) { (loginsignup) in
                         if loginsignup.success {
                             userDefaults.setValue(usernameTrimmed, forKey: "username")
                             let viewController = ViewController()
                             self.navigationController?.pushViewController(viewController, animated: true)
                         }else{
                             self.label.text = loginsignup.data
                         }
                     }
                     
                     
                     //
                     
                    
                }
            }
        }

        
    }
    
    @objc func setUsernameVariable(){
        let username = textBox.text ?? ""
        let password = passwordTextBox.text ?? ""
        let usernameTrimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)
        print(usernameTrimmed)
        
        if usernameTrimmed == ""{
            self.label.text = "Please enter a value in the username field"
        }else{
            if password == ""{
                self.label.text = "Please enter a value in the password field"
            }else{
                if (password.count<6){
                    self.label.text = "Password must be at least 6 characters"
                }else{
                    
                     self.label.text = ""
                     //
                     
                     NetworkManager.loginUser(username: usernameTrimmed, password: password) { (loginsignup) in
                     
                         if loginsignup.success {
                             userDefaults.setValue(usernameTrimmed, forKey: "username")
                             let viewController = ViewController()
                             self.navigationController?.pushViewController(viewController, animated: true)
                         }else{
                             self.label.text = loginsignup.data
                         }
                     }
                     
                     
                     //
                     
                    
                }
            }
        }

        
        
    }
    
    func textFieldShouldReturn(_ textBox: UITextField) -> Bool
    {
        textBox.resignFirstResponder()
        return true
    }
    
}
