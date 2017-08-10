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
    }
    
    override func draw(_ dirtyRect: NSRect) {
        self.segmentCount = 2
        self.setLabel(StandartLanguages.english.rawValue, forSegment: 0)
        self.setLabel(StandartLanguages.russian.rawValue, forSegment: 1)
        
        super.draw(dirtyRect)
    }
    
}
