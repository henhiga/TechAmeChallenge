//
//  RepoError.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation


struct GitError: Decodable{
    let message: String
    let status: String
}
