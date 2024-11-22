//
//  HTTP.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation


enum HTTP {
    enum Method: String {
        case get = "GET"
    }
    enum Headers{
        enum Key: String{
            case contentType = "Content-Type"
        }
        enum Value: String{
            case applicationJson = "json"
        }
    }
}
