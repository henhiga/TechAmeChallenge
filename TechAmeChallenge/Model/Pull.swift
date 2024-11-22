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
