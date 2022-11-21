//
//  NetworkRequestConfiguration.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/20/22.
//

import Foundation

protocol NetworkRequestConfiguration {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
}

extension NetworkRequestConfiguration {
    func urlRequest() throws -> URLRequest {
        guard let url = URL(string: path) else {
            throw NetworkRequestConfigurationError.urlNil(urlString: path)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }
}

enum NetworkRequestConfigurationError: Error {
    case urlNil(urlString: String)

    var localizedDescription: String {
        switch self {
        case .urlNil(let urlString):
            return "URL string is invalid \(urlString)"
        }
    }
}
