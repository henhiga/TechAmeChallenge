//
//  TableViewDelegate.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation
import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {
    var repos: [Repo]!
    
    var viewModel: ViewControllerViewModel!
    
    init(repos: [Repo] = Repo.mockedData(), viewModel: ViewControllerViewModel) {
        self.repos = repos
        self.viewModel = viewModel
    }
    
    public func updateRepos(repos: [Repo]){
        self.repos = repos
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == repos.count {
            viewModel.fetchRepo()
        }
    }
}