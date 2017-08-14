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

	var detectedLanguage: Language? {
		didSet {
			if let language = detectedLanguage {
				self.setLabel("\(language.fullName) (auto)", forSegment: self.segmentCount - 1)
			} else {
				self.setLabel("Detect language", forSegment: self.segmentCount - 1)
			}
		}
	}

	var values: [Language]! {
		didSet {
			for (idx, lang) in values.enumerated() {
				self.setLabel(lang.fullName, forSegment: idx)
			}
		}
	}

	subscript (index: Int) -> Language {
		get {
			return self.values[index]
		}
		set (newValue) {
			self.values[index] = newValue
		}
	}
}
