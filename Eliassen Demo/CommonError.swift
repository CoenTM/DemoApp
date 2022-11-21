//
//  CommonError.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/20/22.
//

import Foundation

enum CommonError: MyError {
    case lostSelf

    var alertTitle: String {
        switch self {
        case .lostSelf:
            return ""
        }
    }

    var alertMessage: String {
        switch self {
        case .lostSelf:
            return ""
        }
    }

    var displayError: Bool {
        switch self {
        case .lostSelf:
            return false
        }
    }
}
