//
//  LanguageSearchTextFieldDelegate.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 19.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa

extension TranslateViewController: NSTextFieldDelegate {
	override func controlTextDidChange(_ obj: Notification) {
		languages = Languages.languages.filter({ (lang) -> Bool in
			return lang.fullName.lowercased().hasPrefix(languagePicker.searchTextField.stringValue.lowercased())
		})
		languagePicker.allLanguages.reloadData()
	}
}
