//
//  TranslateTextViewDelegate.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 16.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa

extension TranslateViewController: NSTextViewDelegate {
	func textDidChange(_ notification: Notification) {
		isTranslated = false
		guard !inputTextView.isEmpty else {
			outputTextView.isEmpty = true
			updatePronounceLanguages()
			return
		}
		
		translate()
	}

	func textDidEndEditing(_ notification: Notification) {
		isTranslated = false
		guard !inputTextView.isEmpty else {
			outputTextView.isEmpty = true
			updatePronounceLanguages()
			return
		}


		translate()
	}
}
