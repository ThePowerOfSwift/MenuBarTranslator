//
//  AutocompleteTableCellView.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 17.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class AutocompleteTableCellView: NSTableCellView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        self.textField?.stringValue = "123"
    }
    
}
