//
//  URLComponents.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 12/1/22.
//

import Foundation

extension URLRequest {
    init(requestConfig: NetworkRequestConfiguration) throws {
        guard var components = URLComponents(string: requestConfig.path) else {
            throw NetworkRequestConfigurationError.invalidUrlString(urlString: requestConfig.path)
        }
        components.queryItems = requestConfig.params
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = components.url else {
            throw NetworkRequestConfigurationError.urlNil(urlString: requestConfig.path)
        }
        self.init(url: url)
    }
}
