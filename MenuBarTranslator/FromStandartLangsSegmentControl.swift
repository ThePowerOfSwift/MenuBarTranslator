//
//  FromStandartLangsSegmentControl.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 09.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa
@IBDesignable
class FromStandartLangsSegmentControl: NSSegmentedControl {
    
    enum StandartLanguages: String {
        case russian = "русский"
        case english = "английский"
        case german = "немецкий"

		static let values = [russian, english, german]
    }

	override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		for (idx, lang) in StandartLanguages.values.enumerated() {
			self[idx] = lang.rawValue
		}
    }

	var queue : QueueInt!	

	subscript (index: Int) -> String? {
		get {
			return self.label(forSegment: index)
		}
		set (newValue){
			self.setLabel(newValue ?? "", forSegment: index)
		}
	}
}
