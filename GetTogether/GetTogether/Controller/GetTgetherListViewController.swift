//
//  GetTgetherListViewController.swift
//  GetTogether
//
//  Created by Hailey Lee on 2020/02/03.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class GetTgetherListViewController: UIViewController {

    let tableView = UITableView()
    var promisses = [Promise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "약속 리스트"
        [tableView].forEach {
            view.addSubview($0)
        }
        setupConstraint()
        setData()
        dump(promisses)
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PromiseCell")
    }

    private func setupConstraint() {
        let guide = self.view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor,constant: 0),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0)
        ])
    }
    
    func setData() {
        for i in 0...20 {
            let promiss = Promise(date: "date\(i)", members: "memebers\(i)", placeTitle: "placeTitle\(i)", placeLatitude: Double(i), placeLongitude: Double(i), comment: "comment\(i)")
            promisses.append(promiss)
        }
    }

}

// MARK: - UITableViewDataSource
extension GetTgetherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promisses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromiseCell", for: indexPath)
        let data = promisses[indexPath.row]
        cell.textLabel?.text = data.placeTitle
        return cell
    }
    
    
}
