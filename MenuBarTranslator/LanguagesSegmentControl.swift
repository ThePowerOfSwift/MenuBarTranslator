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


	enum SegmentConstrols: Int {
		case first = 0
		case second = 1
		case third = 2
		case detect = 3
	}

	override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		if #available(OSX 10.12.2, *) {
			self.selectedSegmentBezelColor = NSColor.darkGray
		}
		self.segmentStyle = .capsule
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

	var currectLanguage: Language? {
		return self[self.selectedSegment]
	}

	var values: [Language]! {
		didSet {
			for (idx, lang) in values.enumerated() {
				self.setLabel(lang.fullName, forSegment: idx)
			}
		}
	}

	subscript (index: Int) -> Language? {
		get {
			if index == SegmentConstrols.detect.rawValue {
				return detectedLanguage
			}
			return self.values[index] as Language?
		}
		set (newValue) {
			if index == SegmentConstrols.detect.rawValue {
				self.detectedLanguage = newValue
			}
			if let value = newValue {
				self.values[index] = value
			}
		}
	}
}
