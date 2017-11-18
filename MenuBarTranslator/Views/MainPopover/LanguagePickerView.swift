//
//  LanguagePickerView.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 17.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
class LanguagePickerView: NSView{

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		setup()
	}

	required init?(coder decoder: NSCoder) {
		super.init(coder: decoder)
		setup()
	}

	private func setup() {
		
	}
}
