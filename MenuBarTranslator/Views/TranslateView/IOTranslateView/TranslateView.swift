//
//  TranslateView.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 28.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

@IBDesignable
class TranslateView: NSView {
	@IBOutlet weak var pronounceButton: PronounceButton!
	@IBOutlet var textView: TranslateTextView!

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
		guard let contentView = loadViewFromNib() else { return }
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
				if let view = tlo as? NSView { return view }
			}
		}
		return nil
	}

	private func setup() {
		textView.isEditable = false
		textView.isSelectable = true
		pronounceButton.isEnabled = false
	}
    
}
