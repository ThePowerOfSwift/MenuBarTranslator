//
//  TranslateTextViewDelegates.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 16.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa


extension TranslateViewController: NSTextViewDelegate {
	func textDidChange(_ notification: Notification) {
	}

	func textView(_ textView: NSTextView, completions words: [String], forPartialWordRange charRange: NSRange, indexOfSelectedItem index: UnsafeMutablePointer<Int>?) -> [String] {
		return ["some shit", "yes", "no"]
	}
}
