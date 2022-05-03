//
//  ApiListView-ViewModel.swift
//  Eliassen Demo
//
//  Created by Takamaru Miki on 5/3/22.
//

import Foundation

extension ApiListView {
	class ViewModel: ObservableObject {
		@Published var apiList = [ApiItem]()
		var listLoaded = false
		var categories = [String]()
		
		private let apiEndpoint = "https://api.publicapis.org/entries"
		
		func fetchApiList(completion: @escaping (Result<String, Error>) -> Void) {
			guard let url = URL(string: apiEndpoint) else {
				return
			}
			
			let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
				if let error = error {
					completion(.failure(error))
				}
				else if let data = data {
					do {
						let response = try JSONDecoder().decode(ApiResponse.self, from: data)
						
						self?.getUniqueCategories(from: response.entries)
						
						DispatchQueue.main.async {
							self?.apiList = response.entries
							self?.listLoaded = true
						}
						completion(.success("Api List was successfully fetched!"))
					}
					catch {
						completion(.failure(error))
					}
				}
			}
			task.resume()
		}
		
		func getUniqueCategories(from apiItems: [ApiItem]) {
			var categorySet = Set<String>()
			
			for apiItem in apiItems {
				if !categorySet.contains(apiItem.category) {
					categorySet.insert(apiItem.category)
				}
			}
			
			categories = [String](categorySet)
			categories.sort()
		}
	}
}
