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
		isChoosen = false
		isHighlighted = false
	}

	private func getToNormal () {
		self.view.layer?.borderColor = NSColor.clear.cgColor
		self.view.layer?.borderWidth = 0.0
		self.view.layer?.backgroundColor = NSColor.white.cgColor
	}

	var isChoosen : Bool! {
		didSet {
			if isChoosen {
				self.view.layer?.borderColor = NSColor(red:0.6, green:0.6, blue:0.6, alpha:1.00).cgColor
				self.view.layer?.borderWidth = 0.5
				self.view.layer?.backgroundColor = NSColor(red:0.8, green:0.8, blue:0.8, alpha:1.00).cgColor
			} else {
				getToNormal ()
			}
		}
	}

	var isHighlighted: Bool! {
		didSet {
			if isHighlighted && !isChoosen {
				self.view.layer?.borderColor = NSColor.blue.cgColor
				self.view.layer?.borderWidth = 1.0
				self.view.layer?.backgroundColor = NSColor(red:0.93, green:0.93, blue:0.93, alpha:1.00).cgColor
			} else if !isChoosen {
				getToNormal ()
			}
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
