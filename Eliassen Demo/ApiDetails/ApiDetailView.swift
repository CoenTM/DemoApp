//
//  ApiDetailView.swift
//  Eliassen Demo
//
//  Created by Takamaru Miki on 5/3/22.
//

import SwiftUI

struct ApiDetailView: View {
	let apiItem: ApiItemDTO
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				
				Section(header: "About", description: apiItem.description)
				
				Section(header: "Authorization", description: apiItem.authType)
				
				Section(header: "HTTPS Request", description: apiItem.isHttpsRequest ? "Yes" : "No")
				
				Section(header: "Link", description: apiItem.urlString, isLink: true)
				
				Section(header: "Category", description: apiItem.category)
			}
			.padding(.horizontal)
		}
		.navigationTitle(apiItem.title)
    }
	
	struct Section: View {
		let header: String
		let description: String
		var isLink = false
		
		var body: some View {
			VStack(alignment: .leading, spacing: 5) {
				Text(header)
					.font(.title2)
					.bold()
				Divider()
				if isLink, let url = URL(string: description) {
					Link(destination: url) {
						Text(description)
							.multilineTextAlignment(.leading)
					}
				}
				else {
					Text(description)
						.font(.body)
				}
			}
		}
	}
	
}

struct ApiDetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			ApiDetailView(apiItem: ApiItemDTO.example)
		}
    }
}
