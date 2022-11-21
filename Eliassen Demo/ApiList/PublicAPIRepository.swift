//
//  PublicAPIRepository.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/20/22.
//

import Foundation

class PublicAPIRepository {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    public func fetchPublicApis() async throws -> [ApiItem] {
        let config = RequestConfiguration.fetchPublicApis
        let response: ApiResponse = try await networkClient.jsonTask(with: config)
        return response.entries
    }
}

extension PublicAPIRepository {
    private enum RequestConfiguration: NetworkRequestConfiguration {
        case fetchPublicApis

        var path: String {
            switch self {
            case .fetchPublicApis:
                return "https://api.publicapis.org/entries"
            }
        }

        var httpMethod: HTTPMethod {
            switch self {
            case .fetchPublicApis:
                return .get
            }
        }
    }
}

struct ApiResponse: Codable {
    var count: Int
    var entries: [ApiItem]
}

struct ApiItem: Codable, Hashable {
    var title: String
    var description: String
    var authType: String
    var isHttpsRequest: Bool
    var cors: String
    var urlString: String
    var category: String

    enum CodingKeys: String, CodingKey {
        case title = "API"
        case description = "Description"
        case authType = "Auth"
        case isHttpsRequest = "HTTPS"
        case cors = "Cors"
        case urlString = "Link"
        case category = "Category"
    }
}


extension ApiItem {
    static let example = ApiItem(title: "Get a Cat", description: "This is an api to find a cat in need of help", authType: "Bearer Token", isHttpsRequest: true, cors: "Yes", urlString: "https://getacat.com.apis/", category: "Charity")
}
