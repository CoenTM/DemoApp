//
//  ContentView.swift
//  Eliassen Demo
//
//  Created by Takamaru Miki on 5/3/22.
//

import SwiftUI

struct ContentView: View {
    private struct Constants {
        static let tabBarIconColor: Color = .cyan
    }

    var body: some View {
        NavigationView {
            TabView {
                ApiListView()
                    .tabItem {
                        Label("Publlic Apis", systemImage: "list.dash")
                    }

                ApiSearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
            }
            .accentColor(Constants.tabBarIconColor)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("MyApp")
                            .foregroundColor(.cyan)
                            .font(.title2)
                        Image(systemName: "star.fill")
                            .foregroundColor(.cyan)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
