//
//  TappableTextView.swift
//  Eliassen Demo
//
//  Created by Takamaru Miki on 5/3/22.
//

import SwiftUI

struct TappableTextView: UIViewRepresentable {
	var text: NSMutableAttributedString
	var linkTextAttributes: [NSAttributedString.Key : Any]
	
	
	// The system calls this method only once.
	func makeUIView(context: Context) -> UITextView {
		let textView = UITextView()
		textView.linkTextAttributes = linkTextAttributes
		textView.attributedText = text
		textView.isEditable = false
		return textView
		// At this point the text view has size 0
	}
	
	func updateUIView(_ uiView: UITextView, context: Context) {
	}
}
