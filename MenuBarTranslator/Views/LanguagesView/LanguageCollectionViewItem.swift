//
//  LanguageCollectionViewItem.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 18.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class LanguageCollectionViewItem: NSCollectionViewItem {

	@IBOutlet weak var languageLabel: NSTextField!
	@IBOutlet weak var languageImage: NSImageView!

	var language: Language? {
		didSet {
			guard isViewLoaded, let language = language else {
				return
			}
			languageLabel.stringValue = language.fullName
			languageImage.image = language.image
		}
	}

	override var isSelected: Bool {
		didSet {
			if (isSelected) {
				self.view.layer?.backgroundColor = UIOptions.highlightedBGColor.cgColor
				self.languageLabel.layer?.backgroundColor = UIOptions.highlightedBGColor.cgColor
			} else {
				self.view.layer?.backgroundColor = UIOptions.backgroundColor.cgColor
				self.languageLabel.layer?.backgroundColor = UIOptions.backgroundColor.cgColor
			}
		}
	}

	override func mouseEntered(with event: NSEvent) {
		isSelected = true
	}

	override func mouseExited(with event: NSEvent) {
		isSelected = false
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addTrackingArea(NSTrackingArea(rect: view.bounds, options: [.activeInActiveApp, .mouseEnteredAndExited], owner: self, userInfo: nil))
		view.wantsLayer = true
		view.layer?.cornerRadius = UIOptions.cornerRadius
	}

}
