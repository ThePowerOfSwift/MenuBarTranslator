//
//  Language.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 11.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa

struct Language: Equatable {

	let shortName: String
	let fullName: String
	var isPronunciationAvailable: Bool

	init(shortName: String, fullName: String, isPronunciationAvailable: Bool = false) {
		self.shortName = shortName
		self.fullName = fullName
		self.isPronunciationAvailable = isPronunciationAvailable;
	}

	public static func ==(lang1: Language, lang2: Language) -> Bool {
		return lang1.fullName == lang2.fullName && lang2.shortName == lang1.shortName
	}

	var image: NSImage? {
		return NSImage(named: NSImage.Name(shortName))
	}
}

struct TranslateDirection {
	var from: Language
	var to: Language

	init(from: Language, to: Language) {
		self.from = from
		self.to = to
	}

	init(to: Language) {
		self.init(from: Languages.auto, to: to)
	}

	var string: String {
		if from == Languages.auto {
			return "\(to.shortName.lowercased())"
		}
		return "\(from.shortName.lowercased())-\(to.shortName.lowercased())"
	}
}
