//
//  LanguagesSegmentControl.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 09.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

@IBDesignable
class LanguagesSegmentControl: NSSegmentedControl {

	override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

	var queue : QueueInt!	

	var values: [Language]! {
		didSet {
			for (idx, lang) in values.enumerated() {
				self[idx] = lang.fullName
			}
		}
	}

	subscript (index: Int) -> String? {
		get {
			return self.label(forSegment: index)
		}
		set (newValue){
			self.setLabel(newValue ?? "", forSegment: index)
		}
	}
}
