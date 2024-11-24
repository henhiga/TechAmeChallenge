//
//  PullViewController.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import UIKit

class PullViewController: UIViewController {
    
    var viewModel: PullViewControllerViewModel
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(PullCell.self, forCellReuseIdentifier: PullCell.identifier)
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
    
    init(viewModel: PullViewControllerViewModel = PullViewControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableViewDelegate = PullTableViewDelegate(pulls: self.viewModel.pulls, navigationController: self.navigationController!)
    lazy var tableViewDataSource = PullTableViewDataSource(pulls: self.viewModel.pulls)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupMsgLabel()
        self.viewModel.onPullUpdated = { [weak self] in
            DispatchQueue.main.async {
                if (self!.viewModel.pulls.isEmpty){
                    self?.msgLabel.text = "There is no open Pull Requests"
                } else {
                    self?.tableViewDataSource.setPulls(pulls: self?.viewModel.pulls ?? [])
                    self?.tableViewDelegate.setPulls(pulls: self?.viewModel.pulls ?? [])
                    self?.tableView.reloadData()
                    self?.msgLabel.isHidden = true
                }
            }
        }
        self.viewModel.onErrorMessage = { [weak self] error in
                self?.msgLabel.text = "error fetching: \(error.localizedDescription)"
            DispatchQueue.main.async{
                switch error{
                case .serverError(let serverError):
                    self?.msgLabel.text = "server error: \(serverError)"
                case .unknown(let string):
                    self?.msgLabel.text = "error fetching: \(string)"
                case .decodingError(let string):
                    self?.msgLabel.text = "error parsing data: \(string)"
                }
            }
        }
    }
    
    func setupMsgLabel(){
        self.view.addSubview(msgLabel)
        NSLayoutConstraint.activate([
            msgLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            msgLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            msgLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            msgLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    func setupTableView(){
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    
    

}
