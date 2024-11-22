//
//  ViewControllerViewModel.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation


class ViewControllerViewModel {
    var onRepoUpdated: (()->Void)?
    var onErrorMessage: ((GitServiceError)->Void)?
    
    var fetchCount = 1
    
    private(set) var repos: [Repo] = []{
        didSet {
            self.onRepoUpdated?()
        }
    }
    init() {
        self.fetchRepo()
    }
    
    public func fetchRepo(){
        let endpoint = Endpoint.fetchRepo(page: fetchCount.formatted())
        self.fetchCount+=1
        RepoService.fetchAirQuality(with: endpoint){ [weak self] result in
            switch result{
            case .success(let repos):
                self?.repos.append(contentsOf: repos)
                print("fetched \(repos.count) items")
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
            
        }
    }
}
