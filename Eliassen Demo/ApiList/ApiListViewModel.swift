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
		private (set) var categories = [APICategory]()

        private let repo = PublicAPIRepository(networkClient: GlobalNetworkClient())

        private (set) var alertDataSource: AlertDataSource = AlertDataSource(title: "", message: "", alertItems: [])
        @Published var showErrorAlert = false

        @Published var showLoadingView = false
		
		func fetchApiList() {
            showLoadingView = true
            Task {
                do {
                    let publicApis = try await repo.fetchPublicApis()
                    getCategories(from: publicApis)
                    await MainActor.run {
                        apiList = publicApis
                    }
                } catch {
                    if let error = error as? MyError, error.displayError == true {
                        alertDataSource = AlertDataSource(title: error.alertTitle, message: error.alertMessage, alertItems: [AlertItem(id: UUID().uuidString, title: "OK", role: .cancel)])
                        await MainActor.run {
                            showErrorAlert = true
                        }
                    }
                }
                await MainActor.run {
                    showLoadingView = false
                }
            }
		}
		
		private func getCategories(from apiItems: [ApiItem]) {
			var categories = [APICategory]()
			
			for apiItem in apiItems {
                if let appendAt = categories.firstIndex(where: { $0.title == apiItem.category }) {
                    categories[appendAt].apiList.append(apiItem)
                } else {
                    categories.append(APICategory(id: UUID().uuidString, title: apiItem.category, apiList: []))
                }
			}
			
            self.categories = categories.sorted { $0.title < $1.title }
		}
	}
}
