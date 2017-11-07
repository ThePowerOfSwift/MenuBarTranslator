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
	func switchHiddennessoutputTextView () {
		if(inputTextView.isEmpty && !TranslateViewController.isoutputTextViewAlreadyHidden) {
			TranslateViewController.isoutputTextViewAlreadyHidden = true
			outputTextView.isHidden = true
			outputTextView.isEmpty = true
		}
		else if TranslateViewController.isoutputTextViewAlreadyHidden {
			TranslateViewController.isoutputTextViewAlreadyHidden = false
			outputTextView.isHidden = false
		}

		fromLangSegControl.detectedLanguage = nil
	}

	func textDidEndEditing(_ notification: Notification) {
		switchHiddennessoutputTextView()
// MARK: Setting translated text to output
		self.translateText()
	}

	func textDidChange(_ notification: Notification) {
		if let textView = notification.object as? NSTextView {
			textView.textStorage?.setAttributes( [NSAttributedStringKey.font: Options.font as Any], range: NSRange(location: 0, length: textView.string.count))
		}
		switchHiddennessoutputTextView()
// MARK: Setting translated text to output
		self.translateText()
	}


	
}
