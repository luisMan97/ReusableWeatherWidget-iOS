//
//  APIManager.swift
//  ReusableWeatherWidget-iOS
//
//  Created by Jorge Luis Rivera Ladino on 23/07/25.
//

import Foundation

public protocol APIManagerProtocol: Sendable {
    func request<T: Decodable>(service: APIRouter) async throws -> T
}

public struct APIManager: APIManagerProtocol {

    public init() {
        
    }

    public func request<T: Decodable>(service: APIRouter) async throws -> T {
        guard let request = service.urlRequest else { throw URLError(.badURL) }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

