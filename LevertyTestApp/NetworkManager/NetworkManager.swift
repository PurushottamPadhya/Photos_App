//
//  NetworkManager.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 31/1/22.
//

import Foundation

class NetworkManager{
    enum NetworkError: Error{
        case invalidUrl
        case invalidData
    }
    
    
    func ApiRequest<T:Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void){
           
            guard let url = url else{
                completion(.failure(NetworkError.invalidUrl))
                return
            }
            
           
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else{
                    if let error = error {
                        completion (.failure(error))
                    }
                    else{
                        completion(.failure(NetworkError.invalidData))
                    }
                    return
                }
                do {
                    let result = try JSONDecoder().decode(expecting, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }

            }
            task.resume()
            
            
            
    }
    
    
}
