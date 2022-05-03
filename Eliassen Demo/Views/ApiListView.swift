//
//  ApiListView.swift
//  Eliassen Demo
//
//  Created by Takamaru Miki on 5/3/22.
//

import SwiftUI

struct ApiListView: View {
	@StateObject var viewModel = ViewModel()
	
	@State private var alertTitle = ""
	@State private var alertMessage = ""
	@State private var showingAlert = false
	
    var body: some View {
		List {
			ForEach(viewModel.categories, id: \.self) { category in
				let apis = viewModel.apiList.filter { $0.category == category }
				Section(category) {
					ForEach(apis, id: \.self) { apiItem in
						NavigationLink {
							ApiDetailView(apiItem: apiItem)
						} label: {
							Row(item: apiItem)
						}
					}
				}
			}
		}
		.listStyle(.sidebar)
		.onAppear {
			if !viewModel.listLoaded { loadApiList() }
		}
		.toolbar {
			ToolbarItem {
				Button("Reload") {
					loadApiList()
				}
			}
		}
		.alert(alertTitle, isPresented: $showingAlert) {
			Button("OK") {}
		} message: {
			Text(alertMessage)
		}
		.navigationTitle("Api List")
    }
	
	private func loadApiList() {
		viewModel.fetchApiList { result in
			switch result {
				case .success(let message):
					print(message)
				case .failure(let error):
					alertTitle = "Error!"
					alertMessage = "\(error.localizedDescription). Please tap Reload on the toolbar to try it again."
					showingAlert = true
			}
		}
	}
	
	struct Row: View {
		let item: ApiItem
		
		var body: some View {
			VStack(alignment: .leading) {
				Text(item.title)
					.font(.headline)
					.bold()
					.padding(.bottom, 5)
				
				Text(item.description)
					.multilineTextAlignment(.leading)
					.font(.callout)
			}
		}
	}
}

struct ApiListView_Previews: PreviewProvider {
    static var previews: some View {
        ApiListView()
    }
}
