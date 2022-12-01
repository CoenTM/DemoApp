//
//  ApiSearchView.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/30/22.
//

import SwiftUI

struct ApiSearchView: View {
    @StateObject var viewModel = ViewModel()
    @FocusState private var isSearchFieldFocused: Bool

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(.systemGray3))

                    TextField("Search", text: $viewModel.searchText)
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

            List {
                ForEach(viewModel.searchSuggestions, id: \.self) {
                    Text($0)
                        .font(.body)
                }
            }
            .listStyle(.plain)

            Spacer()
        }
        .padding(.horizontal, 8)
    }
}

struct ApiSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ApiSearchView()
    }
}
