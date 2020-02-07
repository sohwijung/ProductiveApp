//
//  HistoryViewController.swift
//  
//
//  Created by Sohwi Jung on 11/23/19.
//

import UIKit

class HistoryViewController: UIViewController {

    var tableView: UITableView!
    var userHistory: [UserData] = []
    let cellHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.getAllData(username: userDefaults.string(forKey: "username")!) { (responseData) in
            self.userHistory = responseData
            print(self.userHistory)
            print(self.userHistory.count)
            self.tableView.reloadData()
        }
        title = "History"
        view.backgroundColor = .white
        
        tableView = UITableView()
        tableView.rowHeight = 55
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "identifier")
        view.addSubview(tableView)
        
        setupConstraints()

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    

}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(userHistory.count)
        return userHistory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) as! HistoryTableViewCell
        let userData = userHistory[indexPath.row]
        print(indexPath.row)
        print(userData)
        let user = User(water: userData.water_data, exercise: userData.fitness_data_duration, mood: userData.mood_data, sleep: userData.sleep_data, date: userData.date)
        cell.configure(for: user)
        return cell
    }
}

