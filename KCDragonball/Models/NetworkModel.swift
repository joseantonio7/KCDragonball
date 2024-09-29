//
//  NetworkModel.swift
//  KCDragonball
//
//  Created by José Antonio Aravena on 28-09-24.
//

import Foundation

final class NetworkModel {
    static let shared = NetworkModel()
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    private var token:String?
    private let client :APIClientProtocol
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func login(user: String, password: String, completion: @escaping (Result<String, NetworkError> ) -> Void) {
        var components = baseComponents
        components.path = "/api/auth/login"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.noData))
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        let decoder = { data in
            return String(data: data, encoding: .utf8)
        }
        client.request(request, using: String.self, decoder: decoder) { [weak self] result in
            switch result {
            case let .success(token):
                self?.token = token
            case .failure:
                break
            }
            completion(result)
        }
    }
    
    func getHeroes(completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        var componets = baseComponents
        componets.path = "/api/heros/all"
        
        guard let url = componets.url else {
            completion(.failure(.malformedURL))
            return
        }
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["name": ""]) else {
            completion(.failure(.serializetionFailed))
            return
        }
        guard let token else {
            completion(.failure(.notLoged))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.httpBody = serializedBody
        
        let decoder = { data in
            return try? JSONDecoder().decode([Hero].self, from: data)
        }
        
        client.request(request, using: [Hero].self, decoder: decoder, completion: completion)
    }
    
    func getTransformations(for hero: Hero, completion: @escaping (Result<[Transformation], NetworkError>) -> Void) {
        var componets = baseComponents
        componets.path = "/api/heros/tranformations"
        
        guard let url = componets.url else {
            completion(.failure(.malformedURL))
            return
        }
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["id": hero.id]) else {
            completion(.failure(.serializetionFailed))
            return
        }
        guard let token else {
            completion(.failure(.notLoged))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.httpBody = serializedBody
        
        let decoder = { data in
            return try? JSONDecoder().decode([Transformation].self, from: data)
        }
        
        client.request(request, using: [Transformation].self, decoder: decoder, completion: completion)
    }
}
