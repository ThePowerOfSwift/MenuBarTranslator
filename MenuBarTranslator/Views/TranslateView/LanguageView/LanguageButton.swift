//
//  LanguageButton.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 19.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class LanguageButton: NSButton {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    var language: Language? {
        didSet {
            reloadData()
        }
    }

    func reloadData() {
        guard let language = language else {
            return
        }
        self.title = language.fullName
    }

}
