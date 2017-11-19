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
		guard !inputTextView.isEmpty else {
			outputTextView.isEmpty = true
			inputPronounceButton.isEnabled = false
			return
		}
		outputPronounceButton.isEnabled = !outputTextView.isEmpty
		if inputLanguageButton.language == Languages.auto {
			Dictionary.shared.detectLanguage(by: inputTextView.string, completion: { (lang) in
				guard let lang = lang else {
					return
				}
				self.inputLanguageButton.language = Languages.searchLanguage(by: lang)

				guard let language = self.inputLanguageButton.language else {
					self.inputLanguageButton.language = Languages.auto
					self.updatePronounceLanguages()
					return
				}
				
				self.updatePronounceLanguages()

				let direction = TranslateDirection(from: language, to: self.outputLanguageButton.language!)
				self.translate(text: self.inputTextView.string, with: direction)
			})

		} else {
			let direction = TranslateDirection(from: inputLanguageButton.language!, to: outputLanguageButton.language!)
			translate(text: inputTextView.string, with: direction)
			self.updatePronounceLanguages()
		}
	}

	func translate(text: String, with direction: TranslateDirection) {
		Dictionary.shared.translate(text, with: direction) { (text) in
			guard let text = text else {
				return
			}
			self.outputTextView.string = text
		}
	}

}
