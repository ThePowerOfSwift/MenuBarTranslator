//
//  LanguageCollectionViewItem.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 12.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class LanguageCollectionViewItem: NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()
		view.wantsLayer = true
		view.layer?.backgroundColor = NSColor.gray.cgColor
		view.layer?.borderColor = NSColor.white.cgColor
		view.layer?.borderWidth = 0.0
    }

	override var isSelected: Bool {
		didSet {
			view.layer?.borderWidth = isSelected ? 5.0 : 0.0
		}
	}

	var language: Language? {
		didSet {
			guard isViewLoaded else { return }
			if let language = language {
				textField?.stringValue = language.fullName
			} else {
				textField?.stringValue = ""
			}
		}
	}
}
