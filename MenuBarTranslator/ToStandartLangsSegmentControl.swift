//
//  ToStandartLangsSegmentControl.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 10.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

@IBDesignable
class ToStandartLangsSegmentControl: NSSegmentedControl {

    enum StandartLanguages: String {
        case russian = "русский"
        case english = "английский"
        case german = "немецкий"
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
}
