//
//  String+Extension.swift
//  Eliassen Demo
//
//  Created by Miki, Takamaru on 11/29/22.
//

import Foundation

extension String {
    var firstCharString: String? {
        count < 1 ? nil : String(first!)
    }
}
