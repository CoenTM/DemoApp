//
//  ApiSearchViewModel.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/30/22.
//

import Foundation

extension ApiSearchView {
    class ViewModel: ObservableObject {
        @Published var searchText = ""
        @Published var searchSuggestions: [ApiItemDTO] = []
        @Published var isSearchFieldFocused = false

        @Published var showAlert = false
        private (set) var alertDataSource = AlertDataSource()

        private var searchResultCache: [String: [ApiItemDTO]] = [:]
        private let repo = PublicAPIRepository(networkClient: GlobalNetworkClient())

        public func searchApis(text: String) {
            if text.isEmpty {
                searchSuggestions = []
                return
            }
            Task {
                if let cache = cacheExists(key: text) {
                    await MainActor.run {
                        if searchText == text {
                            searchSuggestions = cache
                        }
                    }
                    return
                }

                do {
                    let matchingApis = try await repo.searchPublicApis(for: text)
                    searchResultCache[text] = matchingApis
                    await MainActor.run {
                        if searchText == text {
                            searchSuggestions = matchingApis
                        }
                    }
                } catch {
                    if let error = error as? MyError, error.displayError == true {
                        alertDataSource = AlertDataSource(error: error)
                        alertDataSource.alertItems = [AlertItem(id: UUID().uuidString, title: "Cancel", role: .cancel)]
                        self.alertDataSource = alertDataSource
                        await MainActor.run {
                            showAlert = true
                        }
                    }
                }
            }
        }

        private func cacheExists(key: String) -> [ApiItemDTO]? {
            return searchResultCache[key]
        }
    }
}
