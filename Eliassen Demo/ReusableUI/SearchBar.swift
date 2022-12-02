//
//  SearchBar.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 12/1/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @FocusState var isSearchFieldFocused: Bool

    init(searchText: Binding<String>) {
        self._searchText = searchText
    }

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(.systemGray3))

                TextField("Search", text: $searchText)
                    .autocorrectionDisabled(true)
                    .focused($isSearchFieldFocused)
            }
            .padding(4)
            .background(Color(.systemGray6))
            .cornerRadius(10)

            if isSearchFieldFocused {
                Text("Cancel")
                    .foregroundColor(Color(.systemBlue))
                    .onTapGesture {
                        isSearchFieldFocused = false
                    }
            }
        }
        .font(.title3)
    }
}
