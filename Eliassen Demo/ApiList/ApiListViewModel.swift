//
//  ApiListView-ViewModel.swift
//  Eliassen Demo
//
//  Created by Takamaru Miki on 5/3/22.
//

import Foundation

extension ApiListView {
	class ViewModel: ObservableObject {
        var listLoaded = false
		@Published var categories = [APICategory]()
        @Published var selectedSection = ""
        private (set) var uniqueFirstLetters = [String]()
        private (set) var sectionIds = [String]()

        private let repo = PublicAPIRepository(networkClient: GlobalNetworkClient())

        private (set) var alertDataSource = AlertDataSource()
        @Published var showErrorAlert = false

        @Published var showLoadingView = false
		
		func fetchApiList() {
            showLoadingView = true
            Task {
                do {
                    let publicApis = try await repo.fetchPublicApis()
                    let categories = getCategories(from: publicApis)
                    await MainActor.run {
                        self.categories = categories
                        self.listLoaded = true
                    }
                } catch {
                    if let error = error as? MyError, error.displayError == true {
                        var alertDataSource = AlertDataSource(error: error)
                        alertDataSource.alertItems = [AlertItem(id: UUID().uuidString, title: "OK", role: .cancel)]
                        self.alertDataSource = alertDataSource
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

        func reload() {
            reset()
            fetchApiList()
        }

        func jumpToSection(withHeader firstLetter: String) {
            guard let index = uniqueFirstLetters.firstIndex(of: firstLetter) else {
                return
            }
            selectedSection = sectionIds[index]
        }

        private func reset() {
            listLoaded = false
            categories = []
            uniqueFirstLetters = []
            alertDataSource = AlertDataSource(title: "", message: "", alertItems: [])
        }
		
		private func getCategories(from apiItems: [ApiItemDTO]) -> [APICategory] {
			var categories = [APICategory]()
			
			for apiItem in apiItems {
                if let appendAt = categories.firstIndex(where: { $0.title == apiItem.category }) {
                    categories[appendAt].apiList.append(apiItem)
                } else {
                    let categoryId = UUID().uuidString
                    categories.append(APICategory(id: categoryId, title: apiItem.category, apiList: []))
                    considerAddingFirstLetter(of: apiItem.category, categoryId: categoryId)
                }
			}
			
            return categories.sorted { $0.title < $1.title }
		}

        private func considerAddingFirstLetter(of str: String, categoryId: String) {
            guard let firstCharString = str.firstCharString?.uppercased() else {
                return
            }

            guard let latestFirstLetter = uniqueFirstLetters.last else {
                uniqueFirstLetters.append(firstCharString)
                sectionIds.append(categoryId)
                return
            }

            if latestFirstLetter != firstCharString {
                uniqueFirstLetters.append(firstCharString)
                sectionIds.append(categoryId)
            }
        }
	}
}

