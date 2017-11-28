//
//  UIOptions.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 17.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa

struct UIOptions {
    static var cornerRadius: CGFloat = 7
    static var backgroundColor = NSColor.white
    static var textFont = NSFont(name: "Helvetica", size: 15)
    static var highlightedBGColor = NSColor(white: 0.93, alpha: 1.0)
}

extension NSTextView {
    var isEmpty: Bool {
        get {
            return self.string.count == 0
        }
        set {
            if (newValue) {
                self.string = ""
            }
        }
    }
}

extension NSButton {
	var isActive: Bool {
		return self.state == .on
	}
}
