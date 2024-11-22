//
//  PullViewController.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import UIKit

class PullViewController: UIViewController {
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let msgLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading Pull Requests..."
        label.font = UIFont.systemFont(ofSize: 32)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func setupTableView(){
//        tableView.delegate = tableViewDelegate
//        tableView.dataSource = tableViewDataSource
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    

}
