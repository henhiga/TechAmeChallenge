//
//  Repo.swift
//  TechAmeChallenge
//
//  Created by Henrique on 21/11/24.
//

import Foundation

struct Repo: Codable {
    let name: String
    let owner: RepoProfile
    
}

struct RepoProfile: Codable{
    let login: String
    let avatar_url: String
}
