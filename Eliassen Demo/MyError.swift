//
//  MyError.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/20/22.
//

import Foundation

protocol MyError: Error {
    var alertTitle: String { get }
    var alertMessage: String { get }
    var displayError: Bool { get }
}
