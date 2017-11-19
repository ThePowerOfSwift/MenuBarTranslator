//
//  ArrayExtention.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 19.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation




extension Array where Element: Equatable {
	mutating func pushFront(_ element: Element) {
		if !self.contains(element) {
			self.insert(element, at: 0)
		}
	}
}
