//
//  AllLanguagesButton.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 15.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

@IBDesignable
class AllLanguagesButton: NSButton {

	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		self.bezelStyle = .texturedSquare
		self.title = "  "
	}
}
