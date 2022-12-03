//
//  ApiListView.swift
//  Eliassen Demo
//
//  Created by Takamaru Miki on 5/3/22.
//

import SwiftUI

struct ApiListView: View {
	@StateObject var viewModel = ViewModel()

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor.clear
    }
	
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                LazyHGrid(rows: viewModel.uniqueFirstLetters.map { _ in GridItem(.flexible()) }) {
                    ForEach(viewModel.uniqueFirstLetters, id: \.self) { firstLetter in
                        Text(firstLetter)
                            .foregroundColor(.pink)
                            .onTapGesture {
                                viewModel.jumpToSection(withHeader: firstLetter)
                            }
                    }
                }
                .padding(.leading, 8)
                .background(Color.listBackGroundColor)

                ScrollViewReader { proxy in
                    List {
                        ForEach(viewModel.categories) { category in
                            Section(category.title) {
                                ForEach(category.apiList) { apiItem in
                                    NavigationLink {
                                        ApiDetailView(apiItem: apiItem)
                                    } label: {
                                        Row(item: apiItem)
                                    }
                                }
                            }
                            .id(category.id)
                        }
                    }
                    .listStyle(.sidebar)
                    .onChange(of: viewModel.selectedSection) { newValue in
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                }
            }

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
        .alert(alertDataSource: viewModel.alertDataSource, isPresented: $viewModel.showErrorAlert)
    }
	
	struct Row: View {
		let item: ApiItemDTO
		
		var body: some View {
            VStack(alignment: .leading, spacing: 0) {
				Text(item.title)
					.font(.headline)
					.bold()
					.padding(.bottom, 8)
				
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
