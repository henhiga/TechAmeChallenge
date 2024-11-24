//
//  Pull.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation

struct PullArray: Decodable{
    let items: [Pull]
}

struct Pull: Codable{
    let url: String
    let title: String
    let user: User
    let updated_at: String
    let body: String
}

struct User: Codable{
    let login: String
    let avatar_url: String
}


extension Pull{
    static func mockedPullData() -> [Pull]{
        let mock = [Pull(url: "asdw", title: "Top", user: User(login: "henriq", avatar_url: "https://avatars.githubusercontent.com/u/484656?v=4"), updated_at: "239", body: "aodo aksdoawd asod aojd aoisd "),
        Pull(url: "asdw", title: "top 2", user: User(login: "mermao", avatar_url: "https://avatars.githubusercontent.com/u/484656?v=4"), updated_at: "2024-11-03T01:48:56Z", body: "aoasda aisdjiajsid iajw dwkd sd disdjw isdajwdo aksdoawd asod aojd a 2392 392u 9u3 oisd ")
        ]
        
        return mock
    }
}
