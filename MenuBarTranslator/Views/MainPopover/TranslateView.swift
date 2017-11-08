//
//  TranslateView.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 07.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class TranslateView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		self.layer?.backgroundColor = CGColor.white
    }


	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		commonInit()
	}

	var textView: NSTextView? = nil
	
	required init?(coder decoder: NSCoder) {
		super.init(coder: decoder)
		commonInit()
	}
	
	private func commonInit() {
		textView = (self.subviews.filter({$0 is NSScrollView}).first as? NSScrollView)?.documentView as? NSTextView
	}

}
