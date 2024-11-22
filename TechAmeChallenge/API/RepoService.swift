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

class RepoService{
    static func fetchAirQuality(with endpoint: Endpoint,
                            completion: @escaping (Result<[Repo], GitServiceError>)->Void){
        guard let request = endpoint.request else {return }
        
        URLSession.shared.dataTask(with: request) { data, resp, error in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200{
                do {
                    let airQualityError = try JSONDecoder().decode(GitError.self, from: data ?? Data())
                    completion(.failure(.serverError(airQualityError)))
                } catch let err {
                    completion(.failure(.unknown()))
                    print(err.localizedDescription)
                }
            }
            
            if let data = data{
                do{
                    let decoder = JSONDecoder()
                    let repoData = try? decoder.decode(RepoArray.self, from: data)
                    completion(.success(repoData?.items ?? []))
                } catch let err {
                    completion(.failure(.decodingError()))
                    print(err.localizedDescription)
                }
            }else {
                completion(.failure(.unknown()))
            }
        }.resume()
    }
}

