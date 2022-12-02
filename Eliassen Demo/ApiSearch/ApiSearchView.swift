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
            SearchBar(searchText: $viewModel.searchText)
                .onChange(of: viewModel.searchText) { newValue in
                    print("MyInfo: newValue \(newValue)")
                    viewModel.searchApis(text: newValue)
                }

            List {
                ForEach(viewModel.searchSuggestions) {
                    Text($0.title)
                        .font(.body)
                }
            }
            .listStyle(.plain)

            Spacer()
        }
        .padding(.horizontal, 8)
        .alert(alertDataSource: viewModel.alertDataSource, isPresented: $viewModel.showAlert)
    }
}

struct ApiSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ApiSearchView()
    }
}
