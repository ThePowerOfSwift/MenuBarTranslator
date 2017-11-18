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
	@IBOutlet weak var contentView: NSView!
	@IBOutlet weak var searchTextField: NSTextField!
	@IBOutlet weak var allLanguagesScrollView: NSScrollView!
	@IBOutlet weak var recentLanguagesScrollView: NSScrollView!
	@IBOutlet weak var searchImage: NSImageView!

	@IBOutlet weak var recentLanguages: NSCollectionView!
	@IBOutlet weak var allLanguages: NSCollectionView!
	@IBOutlet weak var allLanguagesLabel: NSTextField!
	@IBOutlet weak var recentLanguagesLabel: NSTextField!

	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		self.layer?.backgroundColor = UIOptions.backgroundColor.cgColor
		self.layer?.cornerRadius = UIOptions.cornerRadius
	}
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		setup()
	}

	required init?(coder decoder: NSCoder) {
		super.init(coder: decoder)
		setup()
	}

	private func setup() {
		Bundle.main.loadNibNamed(NSNib.Name(rawValue: "LanguagePickerView"), owner: self, topLevelObjects: nil)
		contentView.frame = bounds
		addSubview(contentView)
		
	}
}
