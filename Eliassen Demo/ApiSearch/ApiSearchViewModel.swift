//
//  ApiSearchViewModel.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/30/22.
//

import Foundation

extension ApiSearchView {
    class ViewModel: ObservableObject {
        @Published var searchText = "" {
            didSet {
                searchApis(text: searchText)
            }
        }
        @Published var searchSuggestions: [String] = []

        private var searchResultCache: [String: [String]] = [:]

        private func searchApis(text: String) {
            let querySearchText = searchText
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.searchResultCache[querySearchText] = ["a", "b", "c"]
                if self.searchText == querySearchText {
                    self.searchSuggestions = ["a", "b", "c"]
                }
            }
        }
    }
}
