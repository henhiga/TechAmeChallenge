//
//  ApiService.swift
//  TechAmeChallenge
//
//  Created by Henrique on 23/11/24.
//

import Foundation


class ApiService{
    static func fetchData<T: Decodable>(with endpoint: Endpoint,
                                        modelType: T.Type,
                                        completion: @escaping (Result<T, GitServiceError>) -> Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                do {
                    let gitError = try JSONDecoder().decode(GitError.self, from: data ?? Data())
                    completion(.failure(.serverError(gitError)))
                } catch {
                    completion(.failure(.unknown("Failed to decode server error.")))
                }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError("Failed to decode data.")))
                }
            } else {
                completion(.failure(.unknown("No data received.")))
            }
        }.resume()
    }
}
