//
//  TranslateTextView.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 16.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class TranslateTextView: NSTextView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		commonInit()
	}

	override init(frame frameRect: NSRect, textContainer container: NSTextContainer?) {
		super.init(frame: frameRect, textContainer: container)
		commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	func commonInit() {
		self.textContainerInset = NSSize(width: 2, height: 7)
		self.wantsLayer = true
		self.font = NSFont(name: "Helvetica", size: 15)
		self.isAutomaticSpellingCorrectionEnabled = false
		self.isGrammarCheckingEnabled = false
	}

	override var readablePasteboardTypes: [NSPasteboard.PasteboardType] {
		return [NSPasteboard.PasteboardType.string]
	}
}
