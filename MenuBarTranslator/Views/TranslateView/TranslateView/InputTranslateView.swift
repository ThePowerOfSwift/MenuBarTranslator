//
//  InputTranslateView.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 28.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class InputTranslateView: TranslateView {

	@IBOutlet weak var clearButton: NSButton!
	override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		setup()
	}

	required init?(coder decoder: NSCoder) {
		super.init(coder: decoder)
		setup()
	}

	private func setup() {
		textView.isEditable = true
		textView.isSelectable = true
	}
    
}
