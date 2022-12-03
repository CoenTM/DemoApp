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

    public func fetchPublicApis() async throws -> [ApiItemDTO] {
        let config = RequestConfiguration.fetchPublicApis
        let response: Response = try await networkClient.jsonTask(with: config)
        return response.entries ?? []
    }

    public func searchPublicApis(for text: String) async throws -> [ApiItemDTO] {
        let config = RequestConfiguration.searchPublicApis(text: text)
        let response: Response = try await networkClient.jsonTask(with: config)
        return response.entries ?? []
    }
}

extension PublicAPIRepository {
    private enum RequestConfiguration: NetworkRequestConfiguration {
        case fetchPublicApis
        case searchPublicApis(text: String)

        var path: String {
            switch self {
            case .fetchPublicApis, .searchPublicApis:
                return "https://api.publicapis.org/entries"
            }
        }

        var httpMethod: HTTPMethod {
            switch self {
            case .fetchPublicApis, .searchPublicApis:
                return .get
            }
        }

        var params: [URLQueryItem]? {
            switch self {
            case .searchPublicApis(let searchText):
                return [URLQueryItem(name: "title", value: searchText)]
            default:
                return nil
            }
        }
    }
}

extension PublicAPIRepository {
    struct Response: Codable {
        var count: Int?
        var entries: [ApiItemDTO]?
    }
}

struct ApiItemDTO: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString
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


extension ApiItemDTO {
    static let example = ApiItemDTO(title: "Get a Cat", description: "This is an api to find a cat in need of help", authType: "Bearer Token", isHttpsRequest: true, cors: "Yes", urlString: "https://getacat.com.apis/", category: "Charity")
}
