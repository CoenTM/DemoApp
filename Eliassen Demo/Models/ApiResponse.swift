//
//  ApiResponse.swift
//  Eliassen Demo
//
//  Created by Takamaru Miki on 5/3/22.
//

import Foundation

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
