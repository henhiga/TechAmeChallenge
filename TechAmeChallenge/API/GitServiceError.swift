//
//  ApiManager.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation

enum GitServiceError: Error{
    case serverError(GitError)
    case unknown(String = "Unknown error")
    case decodingError(String = "Error parsing server response.")
}
