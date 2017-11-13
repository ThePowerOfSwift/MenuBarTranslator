//
//  TextViewDelegate.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 07.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa

// MARK: TextView delegate
extension TranslateViewController:  NSTextViewDelegate {

	func textDidEndEditing(_ notification: Notification) {
// MARK: Setting translated text to output
		self.translateText()
	}

	func textDidChange(_ notification: Notification) {
		if let textView = notification.object as? NSTextView {
			textView.textStorage?.setAttributes( [NSAttributedStringKey.font: Options.font as Any], range: NSRange(location: 0, length: textView.string.count))
//			textView.complete(self)
		}

// MARK: Setting translated text to output
		self.translateText()

		pronounceInputButton.isEnabled = inputTranslateView.isPronouncable
		pronounceOutputButton.isEnabled = outputTranslateView.isPronouncable
	}

	func textView(_ textView: NSTextView, completions words: [String], forPartialWordRange charRange: NSRange, indexOfSelectedItem index: UnsafeMutablePointer<Int>?) -> [String] {
		
		return ["hello", "Hello", "Asas"]
	}

}
