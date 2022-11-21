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
		private (set) var categories = [String]()

        private let repo = PublicAPIRepository(networkClient: GlobalNetworkClient())

        private (set) var alertTitle = ""
        private (set) var alertMessage = ""
        @Published var showErrorAlert = false

        @Published var showLoadingView = false
		
		func fetchApiList() {
            showLoadingView = true
            Task {
                do {
                    let publicApis = try await repo.fetchPublicApis()
                    getUniqueCategories(from: publicApis)
                    await MainActor.run {
                        apiList = publicApis
                        showLoadingView = false
                    }
                } catch {
                    if let error = error as? MyError, error.displayError == true {
                        alertTitle = error.alertTitle
                        alertMessage = error.alertMessage
                        await MainActor.run {
                            showErrorAlert = true
                            showLoadingView = false
                        }
                    }
                }
            }
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
