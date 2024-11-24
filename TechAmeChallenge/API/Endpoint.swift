//
//  Endpoint.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation

enum Endpoint {
    case fetchRepo(url: String = "/search/repositories", page: String = "1")
    case fetchPull(url: String = "/search/issues", user: String = "", name: String = "")
    
    var request: URLRequest? {
        guard let url = self.url else {return nil}
        var request = URLRequest(url: url)
        
        request.httpMethod = self.httpMethod
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    private var queryItems: [URLQueryItem]{
        switch self{
        case.fetchRepo( _, let page):
            return[
                URLQueryItem(name: "q", value: "language:Swift"),
                URLQueryItem(name: "sort", value: "stars"),
                URLQueryItem(name: "page", value: page)
            ]
        case .fetchPull(_, let user, let name):
            return [
                URLQueryItem(name: "q", value: "repo:\(user)/\(name)+type:pr+state:open")
            ]
        }
    }
    
    private var path: String{
        switch self {
        case .fetchRepo(let url, _):
            return url
        case .fetchPull(let url, _ , _):
            return url
        }
    }
    
    private var httpMethod: String {
        switch self{
        case .fetchRepo:
            return HTTP.Method.get.rawValue
        case .fetchPull:
            return HTTP.Method.get.rawValue
        }
    }
    public func nextPage(){
        
    }
}
extension URLRequest{
    mutating func addValues(for endpoint: Endpoint){
        switch endpoint {
        case .fetchRepo:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
        case .fetchPull:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
        }
    }
}
