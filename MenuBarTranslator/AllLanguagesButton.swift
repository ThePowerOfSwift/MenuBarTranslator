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
	public override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		self.image = NSImage(named: "all-languages-button")
		let rectanglePath = NSBezierPath(rect: NSRect(x: 0, y: 0, width: self.frame.width-10, height: self.frame.height-10))
		rectanglePath.appendOval(in: NSRect(x: self.frame.width, y: self.frame.height, width: 10, height: 10))

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
