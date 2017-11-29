//
//  BGView.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 28.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class BGView: NSView {

	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)

		self.layer?.cornerRadius = UIOptions.cornerRadius
		self.layer?.backgroundColor = UIOptions.backgroundColor.cgColor
	}

}
