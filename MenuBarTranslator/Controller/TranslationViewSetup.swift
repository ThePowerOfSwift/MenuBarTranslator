//
//  TranslationViewSetup.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 14.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa

extension TranslateViewController {
	func yandexReferenceSetup() {
		yandexReferenceLabel.allowsEditingTextAttributes = true
		yandexReferenceLabel.isSelectable = true

		let attributedString = NSMutableAttributedString(string: yandexReferenceLabel.stringValue)
		let range = attributedString.mutableString.range(of: "\"Yandex Translate\"")
		let font = NSFont(name: "Helvetica", size: 12)

		attributedString.beginEditing()
		attributedString.addAttribute(NSAttributedStringKey.link, value: "https://translate.yandex.ru", range: range)
		attributedString.addAttribute(NSAttributedStringKey.font, value: font!, range: NSRange(location: 0, length: attributedString.string.count))
		attributedString.endEditing()

		yandexReferenceLabel.attributedStringValue = attributedString
	}

	func preferencesButtonSetup() {
		let menu = NSMenu()
		menu.addItem(NSMenuItem(title: "Quit MenuBarTranslator", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
		preferencesButton.menu = menu
	}

	func updatePronounceLanguages() {
		updateInputPronounceButton()
		updateOutputPronounceButton()
	}

	fileprivate func updateOutputPronounceButton() {
		outputView.pronounceButton.language = languageView.outputLanguageButton.language
		outputView.pronounceButton.isEnabled = outputView.pronounceButton.isEnabled && !outputView.textView.isEmpty
	}

	fileprivate func updateInputPronounceButton() {
		inputView.pronounceButton.language = languageView.inputLanguageButton.language
		inputView.pronounceButton.isEnabled = inputView.pronounceButton.isEnabled && !inputView.textView.isEmpty
	}
}
