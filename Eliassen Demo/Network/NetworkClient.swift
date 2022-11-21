//
//  NetworkClient.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/20/22.
//

import Foundation

protocol NetworkClient {
    func jsonTask<T>(with config: NetworkRequestConfiguration) async throws -> T where T : Decodable

    func dataTask(with config: NetworkRequestConfiguration)
}

class GlobalNetworkClient: NetworkClient {
    func jsonTask<T>(with config: NetworkRequestConfiguration) async throws -> T where T : Decodable {
        let urlRequest = try config.urlRequest()
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
                if self == nil {
                    continuation.resume(throwing: CommonError.lostSelf)
                }

                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    do {
                        let response = try JSONDecoder().decode(T.self, from: data)
                        continuation.resume(returning: response)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }.resume()
        }
    }

    public func dataTask(with config: NetworkRequestConfiguration) {
        // TODO: dataTask
    }
}
