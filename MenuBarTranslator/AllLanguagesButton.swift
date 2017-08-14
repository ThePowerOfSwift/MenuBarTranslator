//
//  AllLanguagesButton.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 15.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class AllLanguagesButton: NSButton {
	public override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)

		let rectanglePath = NSBezierPath(rect: NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))


		let fillColor: NSColor = isHighlighted ? NSColor.darkGray : NSColor.lightGray
		let strokeColor: NSColor = isHighlighted ? NSColor.lightGray : NSColor.darkGray
		rectanglePath.fill()

		strokeColor.setStroke()
		rectanglePath.lineWidth = 100
		rectanglePath.stroke()
		fillColor.setFill()
		rectanglePath.fill()
	}
}
