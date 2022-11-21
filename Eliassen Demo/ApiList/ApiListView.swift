//
//  ApiListView.swift
//  Eliassen Demo
//
//  Created by Takamaru Miki on 5/3/22.
//

import SwiftUI

struct ApiListView: View {
	@StateObject var viewModel = ViewModel()
	
    var body: some View {
        ZStack {
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

            if viewModel.showLoadingView {
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.7)
                ProgressView()
                    .tint(Color.white)
                    .scaleEffect(2)
            }
        }
		.onAppear {
            if !viewModel.listLoaded { viewModel.fetchApiList() }
		}
		.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
				Button("Reload") {
                    viewModel.fetchApiList()
				}
			}
		}
        .alert(viewModel.alertTitle, isPresented: $viewModel.showErrorAlert) {
			Button("OK") {}
		} message: {
            Text(viewModel.alertMessage)
		}
		.navigationTitle("Api List")
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
