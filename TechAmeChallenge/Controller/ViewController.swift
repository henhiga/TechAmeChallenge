//
//  ViewController.swift
//  TechAmeChallenge
//
//  Created by Henrique on 21/11/24.
//

import UIKit

class ViewController: UIViewController {
    
//    let repos: [Repo] = Repo.mockedData()
    private let viewModel: ViewControllerViewModel
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let msgLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading Repositories..."
        label.font = UIFont.systemFont(ofSize: 32)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    lazy var tableViewDelegate = TableViewDelegate(repos: viewModel.repos, viewModel: viewModel)
    lazy var tableViewDataSource = TableViewDataSource(repos: viewModel.repos)
    
    init(viewModel: ViewControllerViewModel = ViewControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Github TechAme"
        self.view.backgroundColor = .white
        setupTableView()
        setupMsgTxt()
        self.viewModel.onRepoUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewDelegate.updateRepos(repos: self?.viewModel.repos ?? [])
                self?.tableViewDataSource.updateRepos(repos: self?.viewModel.repos ?? [])
                self?.tableView.reloadData()
                self?.msgLabel.isHidden = true
            }
        }
        self.viewModel.onErrorMessage = { [weak self] error in
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
    
    func setupMsgTxt(){
        view.addSubview(msgLabel)
        NSLayoutConstraint.activate([
            msgLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            msgLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            msgLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
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

