//
//  AlertDataSource.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/21/22.
//

import Foundation
import SwiftUI

struct AlertDataSource {
    var title: String
    var message: String
    var alertItems: [AlertItem]

    init(title: String = "", message: String = "", alertItems: [AlertItem] = []) {
        self.title = title
        self.message = message
        self.alertItems = alertItems
    }

    init(error: MyError) {
        self.title = error.alertTitle
        self.message = error.alertMessage
        self.alertItems = []
    }
}

struct AlertItem: Identifiable {
    let id: String
    let title: String
    let role: ButtonRole
}

extension View {
    func alert(alertDataSource: AlertDataSource, isPresented: Binding<Bool>) -> some View {
        self
            .alert(alertDataSource.title, isPresented: isPresented) {
                ForEach(alertDataSource.alertItems) {
                    Button($0.title, role: $0.role) {}
                }
            }
    }
}

