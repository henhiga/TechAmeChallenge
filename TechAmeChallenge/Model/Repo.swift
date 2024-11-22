//
//  Repo.swift
//  TechAmeChallenge
//
//  Created by Henrique on 21/11/24.
//

import Foundation

struct RepoArray: Decodable{
    let items: [Repo]
}

struct Repo: Codable {
    let name: String
    let owner: RepoProfile
    let description: String
    let stargazers_count: Int
    let forks_count: Int
}

struct RepoProfile: Codable{
    let login: String
    let avatar_url: String
}

extension Repo {
    static func mockedData() -> [Repo]{
        let repo = [Repo(name: "top", owner: RepoProfile(login: "henriq", avatar_url: "https://avatars.githubusercontent.com/u/484656?v=4"), description: "uma aplicacao para bla sawdasd wdsadkdwkd sdadskd wd asjdjw daskdn wdsk",  stargazers_count: 150, forks_count: 600), Repo(name: "uaulol", owner: RepoProfile(login: "douglas", avatar_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s"), description: "uma aplicacao para bla sawdasd wdsadkdwkd sdadskd wd",  stargazers_count: 300, forks_count: 1000)]
        return repo
    }
}
