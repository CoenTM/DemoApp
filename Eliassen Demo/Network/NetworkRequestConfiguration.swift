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
    var params: [URLQueryItem]? { get }
}

enum NetworkRequestConfigurationError: MyError {
    case urlNil(urlString: String)
    case invalidUrlString(urlString: String)

    var localizedDescription: String {
        switch self {
        case .urlNil(let urlString):
            return "URLComponents.url returned nil url: \(urlString)"
        case .invalidUrlString(let urlString):
            return "URL string(\(urlString)) is invalid"
        }
    }

    var alertTitle: String {
        switch self {
        default:
            return ""
        }
    }

    var alertMessage: String {
        switch self {
        default:
            return ""
        }
    }

    var displayError: Bool {
        switch self {
        default:
            return false
        }
    }
}
