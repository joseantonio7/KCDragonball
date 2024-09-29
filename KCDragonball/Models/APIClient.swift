//
//  APIClient.swift
//  KCDragonball
//
//  Created by José Antonio Aravena on 28-09-24.
//

import Foundation

enum NetworkError: Error, Equatable {
    case malformedURL
    case noData
    case statusCode(code: Int?)
    case decodingFailed
    case notLoged
    case unknown
    case serializetionFailed
}

protocol APIClientProtocol {
    func request<T:Decodable>(_ request:URLRequest, using: T.Type, decoder: @escaping (_ data: Data) -> T?, completion: @escaping (Result<T, NetworkError>) -> Void)
}

struct APIClient: APIClientProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T>(_ request: URLRequest, using: T.Type, decoder: @escaping (_ data: Data) -> T?, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        let task = session.dataTask(with: request){ data, response, error in
            let result: Result<T, NetworkError>
            
            defer{
                completion(result)
            }
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            guard let data else {
                result = .failure(.noData)
                return
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            guard let model = decoder(data) else {
                result = .failure(.decodingFailed)
                return
            }
            result = .success(model)
                    
        }
        
        task.resume()
    }
    
    
}
