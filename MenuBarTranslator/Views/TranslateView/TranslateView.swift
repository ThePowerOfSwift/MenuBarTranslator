//
//  TranslateView.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 16.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class TranslateView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        self.layer?.cornerRadius = UIOptions.cornerRadius
        self.layer?.backgroundColor = UIOptions.backgroundColor.cgColor
    }

    var textView: NSTextView? {
        return (self.subviews.filter({ $0 is NSScrollView }).first as? NSScrollView)?.documentView as? NSTextView
    }
}
