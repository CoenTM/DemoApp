//
//  Eliassen_DemoApp.swift
//  Eliassen Demo
//
//  Created by Takamaru Miki on 5/3/22.
//

import Firebase
import SwiftUI

@main
struct Eliassen_DemoApp: App {
	
	init() {
		FirebaseApp.configure()
	}
	
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
