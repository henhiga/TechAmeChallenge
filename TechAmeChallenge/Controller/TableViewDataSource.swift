//
//  TableViewDataSource.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    var repos: [Repo]!
    
    init(repos: [Repo] = Repo.mockedData()) {
        self.repos = repos
    }
    
    public func updateRepos(repos: [Repo]){
        self.repos = repos
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as? RepoCell else {
            fatalError("unable do deque repocell in tableviewDataSource")
        }
        cell.configure(with: repos[indexPath.row])
        return cell
    }
    
    
}
