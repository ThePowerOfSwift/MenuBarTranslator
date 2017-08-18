//
//  ExtraThings.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 18.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

extension CGPoint {
	static func ~=(point: CGPoint, rect: CGRect) -> Bool {
		let magic: CGFloat = 30.0
		return magic + rect.origin.x...magic + rect.origin.x + rect.width ~= point.x && rect.origin.y...rect.origin.y + rect.height ~= point.y
	}
}

protocol AutoCompleteKeyDownDelegate{
	func downArrowDidPressed()
	func upArrowDidPressed()
	func leftArrowDidPressed()
	func rightArrowDidPressed()
	func escDidPressed()
	func deleteDidPressed()
}

enum Key: Int {
	case delete = 51
	case esc = 53
	case leftArrow = 123
	case rightArrow = 124
	case downArrow = 125
	case upArrow = 126
}
