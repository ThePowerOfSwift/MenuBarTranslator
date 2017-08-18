//
//  AutoGrowingTextField.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 03.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa


class ResizableTextField: NSTextField {

	var minHeight: CGFloat? = 90
	let bottomSpace: CGFloat = 5

	var heightLimit: CGFloat?
	var lastSize: NSSize?
	var isEditing = false

	var isEmpty: Bool {
		get {
			return self.stringValue.characters.count == 0
		}
		set (value) {
			if value {
				self.stringValue = ""
			}
		}
	}

	override func draw(_ dirtyRect: NSRect) {
		layer?.cornerRadius = 10
		self.focusRingType = .none
//		self.isBordered = false

		super.draw(dirtyRect)
	}

	override func textDidBeginEditing(_ notification: Notification) {
		super.textDidBeginEditing(notification)
		isEditing = true
	}

	override func textDidEndEditing(_ notification: Notification) {
		super.textDidEndEditing(notification)
		isEditing = false
	}

	override func textDidChange(_ notification: Notification) {
		super.textDidChange(notification)
		self.invalidateIntrinsicContentSize()
	}

	override var intrinsicContentSize: NSSize {
		var minSize: NSSize {
			var size = super.intrinsicContentSize
			size.height = minHeight ?? 0
			if(self.isEmpty){
				size.height = size.height * 2 + 5
			}
			return size
		}
		
		if isEditing || lastSize == nil {
			guard let
				textView = self.window?.fieldEditor(false, for: self) as? NSTextView,
				let container = textView.textContainer,
				let newHeight = container.layoutManager?.usedRect(for: container).height
				else {
					return lastSize ?? minSize
			}

			var newSize = super.intrinsicContentSize
			newSize.height = newHeight + bottomSpace

			if let
				heightLimit = heightLimit,
				let lastSize = lastSize, newSize.height > heightLimit {
				newSize = lastSize
			}

			if let
				minHeight = minHeight, newSize.height < minHeight {
				newSize.height = minHeight
			}
			lastSize = newSize

			if(self.isEmpty){
				return minSize
			}
			return newSize
		}
		else {
			return lastSize ?? minSize
		}
	}


}
