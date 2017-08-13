//
//  LanguageCollectionViewItem.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 13.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class LanguageCollectionViewItem: NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

	override var isSelected: Bool {
		didSet {
			self.view.layer?.borderColor = isSelected ? NSColor.gray.cgColor : NSColor.clear.cgColor
			self.view.layer?.borderWidth = isSelected ? 2.0 : 0.0
		}
	}

	var language: Language? {
		didSet {
			guard isViewLoaded else {
				return
			}
			if let language = language, let label = textField {
				label.stringValue = language.fullName
			}

		}
	}
}
