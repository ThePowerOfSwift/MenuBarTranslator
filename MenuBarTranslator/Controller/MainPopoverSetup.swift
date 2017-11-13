//
//  MainPopoverSetup.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 07.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa

extension TranslateViewController {
	func yandexReferenceSetup() {
		yandexAdLabel.allowsEditingTextAttributes = true

		let attributedString = NSMutableAttributedString(string: "Traslated by \"Yandex Translate\"")

		attributedString.addAttribute(NSAttributedStringKey.link, value: "https://translate.yandex.ru", range: NSRange(location: 13, length: 18))
		yandexAdLabel.attributedStringValue = attributedString
		attributedString.endEditing()
	}

	func textViewsSetup() {
		
		inputTextView.delegate = self

		inputTextView.font = Options.font
		outputTextView.font = Options.font

		pronounceInputButton.isEnabled = inputTranslateView.isPronouncable
		pronounceOutputButton.isEnabled = outputTranslateView.isPronouncable

		let offset = NSSize(width: 0, height: 5)
		inputTextView.textContainerInset = offset
		outputTextView.textContainerInset = offset
	}
}
