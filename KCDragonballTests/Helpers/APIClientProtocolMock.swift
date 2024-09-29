//
//  APIClientProtocolMock.swift
//  KCDragonballTests
//
//  Created by José Antonio Aravena on 29-09-24.
//

import Foundation
@testable import KCDragonball

final class APIClientProtocolMock<C:Codable>:APIClientProtocol {
    var session: URLSession = .shared
    
    var didCallRequest = false
    var receivedRequest: URLRequest?
    var receivedResult: Result<C,NetworkError>?

    
    func request<T: Decodable>(_ request: URLRequest, using: T.Type, decoder: @escaping (Data) -> T?, completion: @escaping (Result<T, KCDragonball.NetworkError>) -> Void) where T : Decodable {
        receivedRequest = request
        didCallRequest = true
        
        if let result = receivedResult as? Result<T, NetworkError> {
            completion(result)
        }
        
    }
    
}
