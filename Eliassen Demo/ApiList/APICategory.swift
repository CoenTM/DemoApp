//
//  Category.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/21/22.
//

import Foundation

struct APICategory: Identifiable, Hashable {
    let id: String
    let title: String
    var apiList: [ApiItem]
}
