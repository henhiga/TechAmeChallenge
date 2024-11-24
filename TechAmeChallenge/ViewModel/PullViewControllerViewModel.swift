//
//  PullViewControllerViewModel.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation


class PullViewControllerViewModel {
    var onPullUpdated: (()->Void)?
    var onErrorMessage: ((GitServiceError)->Void)?
    
    var user: String
    var name: String
    
    private(set) var pulls: [Pull] = []{
        didSet {
            self.onPullUpdated?()
        }
    }
    init(user: String = "Alamofire", name: String = "Alamofire") {
        self.name = name
        self.user = user
        self.fetchPulls()
    }
    
    public func fetchPulls(){
        let endpoint = Endpoint.fetchPull(user: self.user, name: self.name)
        ApiService.fetchData(with: endpoint, modelType: PullArray.self){ [weak self] result in
            switch result{
            case .success(let pulls):
                self?.pulls.append(contentsOf: pulls.items)
                print("fetched \(pulls.items.count) pulls")
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
            
        }
    }
}
