//
//  AlertDataSource.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/21/22.
//

import Foundation
import SwiftUI

struct AlertDataSource {
    let title: String
    let message: String
    let alertItems: [AlertItem]
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

