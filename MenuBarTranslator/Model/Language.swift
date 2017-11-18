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

struct Languages {

	static let english = Language(shortName: "en", fullName: "Английский", isPronunciationAvailable: true)
	static let russian = Language(shortName: "ru", fullName: "Русский",  isPronunciationAvailable: true)
	static let turkish = Language(shortName: "tr", fullName: "Турецкий", isPronunciationAvailable: true)
	static let urkanian = Language(shortName: "uk", fullName: "Украинский", isPronunciationAvailable: true)
	static let standart = [english, russian, turkish]

	static var languages: [Language] = [Language(shortName: "auto", fullName: "Автоматически"),
								 Language(shortName: "az", fullName: "Азербайджанский"),
	                             Language(shortName: "sq", fullName: "Албанский"),
								 Languages.english,
	                             Language(shortName: "hy", fullName: "Армянский"),
	                             Language(shortName: "af", fullName: "Африкаанс"),
	                             Language(shortName: "eu", fullName: "Баскский"),
	                             Language(shortName: "be", fullName: "Белорусский"),
	                             Language(shortName: "bn", fullName: "Бенгальский"),
								 Language(shortName: "my", fullName: "Бирманский"),
	                             Language(shortName: "bg", fullName: "Болгарский"),
	                             Language(shortName: "bs", fullName: "Боснийский"),
	                             Language(shortName: "cy", fullName: "Валлийский"),
	                             Language(shortName: "hu", fullName: "Венгерский"),
	                             Language(shortName: "vi", fullName: "Вьетнамский"),
	                             Language(shortName: "ht", fullName: "Гаитянский"),
	                             Language(shortName: "nl", fullName: "Голландский"),
	                             Language(shortName: "el", fullName: "Греческий"),
	                             Language(shortName: "ka", fullName: "Грузинский"),
	                             Language(shortName: "gu", fullName: "Гуджарати"),
	                             Language(shortName: "da", fullName: "Датский"),
	                             Language(shortName: "he", fullName: "Иврит"),
	                             Language(shortName: "yi", fullName: "Идиш"),
	                             Language(shortName: "id", fullName: "Индонезийский"),
	                             Language(shortName: "ga", fullName: "Ирландский"),
	                             Language(shortName: "is", fullName: "Исландский"),
	                             Language(shortName: "es", fullName: "Испанский"),
	                             Language(shortName: "it", fullName: "Итальянский"),
	                             Language(shortName: "kk", fullName: "Казахский"),
	                             Language(shortName: "kn", fullName: "Каннада"),
	                             Language(shortName: "ky", fullName: "Киргизский"),
	                             Language(shortName: "zh", fullName: "Китайский"),
	                             Language(shortName: "ko", fullName: "Корейский"),
	                             Language(shortName: "xh", fullName: "Коса"),
	                             Language(shortName: "lo", fullName: "Лаосский"),
	                             Language(shortName: "lv", fullName: "Латышский"),
	                             Language(shortName: "lt", fullName: "Литовский"),
	                             Language(shortName: "lb", fullName: "Люксембургский"),
	                             Language(shortName: "mk", fullName: "Македонский"),
	                             Language(shortName: "ms", fullName: "Малайский"),
	                             Language(shortName: "ml", fullName: "Малаялам"),
	                             Language(shortName: "mt", fullName: "Мальтийский"),
	                             Language(shortName: "mr", fullName: "Маратхи"),
	                             Language(shortName: "mn", fullName: "Монгольский"),
	                             Language(shortName: "de", fullName: "Немецкий"),
	                             Language(shortName: "ne", fullName: "Непальский"),
	                             Language(shortName: "no", fullName: "Норвежский"),
	                             Language(shortName: "pa", fullName: "Панджаби"),
	                             Language(shortName: "pl", fullName: "Польский"),
	                             Language(shortName: "pt", fullName: "Португальский"),
	                             Language(shortName: "ro", fullName: "Румынский"),
	                             Languages.russian,
	                             Language(shortName: "sr", fullName: "Сербский"),
	                             Language(shortName: "sk", fullName: "Словацкий"),
	                             Language(shortName: "sl", fullName: "Словенский"),
	                             Language(shortName: "su", fullName: "Сунданский"),
	                             Language(shortName: "tg", fullName: "Таджикский"),
	                             Language(shortName: "th", fullName: "Тайский"),
	                             Language(shortName: "te", fullName: "Телугу"),
	                             Languages.turkish,
	                             Language(shortName: "uz", fullName: "Узбекский"),
	                             Language(shortName: "ur", fullName: "Урду"),
	                             Language(shortName: "fi", fullName: "Финский"),
	                             Language(shortName: "fr", fullName: "Французский"),
	                             Language(shortName: "hi", fullName: "Хинди"),
	                             Language(shortName: "hr", fullName: "Хорватский"),
	                             Language(shortName: "cs", fullName: "Чешский"),
	                             Language(shortName: "sv", fullName: "Шведский"),
	                             Language(shortName: "gd", fullName: "Шотландский"),
	                             Language(shortName: "et", fullName: "Эстонский"),
	                             Language(shortName: "jv", fullName: "Яванский"),
	                             Language(shortName: "ja", fullName: "Японский")]

	static var languageDirections = [String: [String]]()

	static func setLanguageDirections(directionsArray: [(String, String)]?) {
		guard let directions = directionsArray else {
			return
		}
		directions.forEach({
			if var array = languageDirections[$0.0] {
				array += [$0.1]
				languageDirections[$0.0] = array
			} else {
				languageDirections[$0.0] = [$0.1]
			}
		})
	}

	static func searchLanguage(byFullName fullName: String) -> Language? {
		return Languages.languages.filter({$0.fullName == fullName}).first
	}

	static func isDirectionExists(fromLanguage from: String, toLanguage to: String) -> Bool {
		if let array = languageDirections[from] {
			return array.contains(to)
		}
		return false
	}


	static func searchLanguage(byShortName shortName: String) -> Language? {
		return Languages.languages.filter({$0.shortName == shortName}).first
	}
}
