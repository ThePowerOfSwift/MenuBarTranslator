//
//  LanguageView.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 29.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

@IBDesignable
class LanguageView: NSView {
	@IBOutlet weak var inputLanguageButton: LanguageButton!
	@IBOutlet weak var outputLanguageButton: LanguageButton!
	@IBOutlet weak var swapButton: NSButton!

	var activeButton: LanguageButton? {
		return inputLanguageButton.isActive && !outputLanguageButton.isActive ? inputLanguageButton :
				!inputLanguageButton.isActive && outputLanguageButton.isActive ? outputLanguageButton : nil
	}

	var isEqualStates: Bool {
		return inputLanguageButton.state == outputLanguageButton.state
	}

	func switchStates() {
		(inputLanguageButton.state, outputLanguageButton.state) = (outputLanguageButton.state, inputLanguageButton.state)
	}

	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
	}

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		xibSetup()
		setup()
	}

	required init?(coder decoder: NSCoder) {
		super.init(coder: decoder)
		xibSetup()
		setup()
	}

	func xibSetup() {
		guard let contentView = loadViewFromNib() else {
			return
		}
		contentView.frame = bounds
		contentView.autoresizingMask = [.width, .height]
		addSubview(contentView)
	}

	func loadViewFromNib() -> NSView! {
		let bundle = Bundle(for: type(of: self))
		let name = NSNib.Name(rawValue: String(describing: type(of: self)))
		let nib = NSNib(nibNamed: name, bundle: bundle)!

		var topLevelObjects: NSArray?
		let success = nib.instantiate(withOwner: self, topLevelObjects: &topLevelObjects)

		if success {
			for tlo in topLevelObjects! {
				if let view = tlo as? NSView {
					return view
				}
			}
		}
		return nil
	}

	private func setup() {

	}

}
