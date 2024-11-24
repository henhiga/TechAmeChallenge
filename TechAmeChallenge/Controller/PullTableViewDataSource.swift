//
//  PullTableViewDataSource.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation
import UIKit

class PullTableViewDataSource: NSObject, UITableViewDataSource {
    
    var pulls : [Pull]!
    init(pulls: [Pull]) {
        self.pulls = pulls
    }
    
    public func setPulls(pulls: [Pull]){
        self.pulls = pulls
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pulls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PullCell.identifier, for: indexPath) as? PullCell else {
            fatalError("unable do deque repocell in tableviewDataSource")
        }
        cell.configure(with: pulls[indexPath.row])
        return cell
    }
    
}
