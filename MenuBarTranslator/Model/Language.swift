//
//  Language.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 11.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation


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
}

struct Languages {

	static let english = Language(shortName: "en", fullName: "английский", isPronunciationAvailable: true)
	static let russian = Language(shortName: "ru", fullName: "русский",  isPronunciationAvailable: true)
	static let turkish = Language(shortName: "tr", fullName: "турецкий", isPronunciationAvailable: true)
	static let urkanian = Language(shortName: "uk", fullName: "украинский", isPronunciationAvailable: true)
	static let standart = [english, russian, turkish]

	static var languages: [Language] = [Language(shortName: "az", fullName: "азербайджанский"),
	                             Language(shortName: "sq", fullName: "албанский"),
	                             Language(shortName: "am", fullName: "амхарский"),
								 Languages.english,
	                             Language(shortName: "ar", fullName: "арабский"),
	                             Language(shortName: "hy", fullName: "армянский"),
	                             Language(shortName: "af", fullName: "африкаанс"),
	                             Language(shortName: "eu", fullName: "баскский"),
	                             Language(shortName: "ba", fullName: "башкирский"),
	                             Language(shortName: "be", fullName: "белорусский"),
	                             Language(shortName: "bn", fullName: "бенгальский"),
	                             Language(shortName: "my", fullName: "бирманский"),
	                             Language(shortName: "bg", fullName: "болгарский"),
	                             Language(shortName: "bs", fullName: "боснийский"),
	                             Language(shortName: "cy", fullName: "валлийский"),
	                             Language(shortName: "hu", fullName: "венгерский"),
	                             Language(shortName: "vi", fullName: "вьетнамский"),
	                             Language(shortName: "ht", fullName: "гаитянский"),
	                             Language(shortName: "gl", fullName: "галисийский"),
	                             Language(shortName: "nl", fullName: "голландский"),
	                             Language(shortName: "mrj", fullName: "горномарийский"),
	                             Language(shortName: "el", fullName: "греческий"),
	                             Language(shortName: "ka", fullName: "грузинский"),
	                             Language(shortName: "gu", fullName: "гуджарати"),
	                             Language(shortName: "da", fullName: "датский"),
	                             Language(shortName: "he", fullName: "иврит"),
	                             Language(shortName: "yi", fullName: "идиш"),
	                             Language(shortName: "id", fullName: "индонезийский"),
	                             Language(shortName: "ga", fullName: "ирландский"),
	                             Language(shortName: "is", fullName: "исландский"),
	                             Language(shortName: "es", fullName: "испанский"),
	                             Language(shortName: "it", fullName: "итальянский"),
	                             Language(shortName: "kk", fullName: "казахский"),
	                             Language(shortName: "kn", fullName: "каннада"),
	                             Language(shortName: "ca", fullName: "каталанский"),
	                             Language(shortName: "ky", fullName: "киргизский"),
	                             Language(shortName: "zh", fullName: "китайский"),
	                             Language(shortName: "ko", fullName: "корейский"),
	                             Language(shortName: "xh", fullName: "коса"),
	                             Language(shortName: "km", fullName: "кхмерский"),
	                             Language(shortName: "lo", fullName: "лаосский"),
	                             Language(shortName: "la", fullName: "латынь"),
	                             Language(shortName: "lv", fullName: "латышский"),
	                             Language(shortName: "lt", fullName: "литовский"),
	                             Language(shortName: "lb", fullName: "люксембургский"),
	                             Language(shortName: "mk", fullName: "македонский"),
	                             Language(shortName: "mg", fullName: "малагасийский"),
	                             Language(shortName: "ms", fullName: "малайский"),
	                             Language(shortName: "ml", fullName: "малаялам"),
	                             Language(shortName: "mt", fullName: "мальтийский"),
	                             Language(shortName: "mi", fullName: "маори"),
	                             Language(shortName: "mr", fullName: "маратхи"),
	                             Language(shortName: "mhr", fullName: "марийский"),
	                             Language(shortName: "mn", fullName: "монгольский"),
	                             Language(shortName: "de", fullName: "немецкий"),
	                             Language(shortName: "ne", fullName: "непальский"),
	                             Language(shortName: "no", fullName: "норвежский"),
	                             Language(shortName: "pa", fullName: "панджаби"),
	                             Language(shortName: "pap", fullName: "папьяменто"),
	                             Language(shortName: "fa", fullName: "персидский"),
	                             Language(shortName: "pl", fullName: "польский"),
	                             Language(shortName: "pt", fullName: "португальский"),
	                             Language(shortName: "ro", fullName: "румынский"),
	                             Languages.russian,
	                             Language(shortName: "ceb", fullName: "себуанский"),
	                             Language(shortName: "sr", fullName: "сербский"),
	                             Language(shortName: "si", fullName: "сингальский"),
	                             Language(shortName: "sk", fullName: "словацкий"),
	                             Language(shortName: "sl", fullName: "словенский"),
	                             Language(shortName: "sw", fullName: "суахили"),
	                             Language(shortName: "su", fullName: "сунданский"),
	                             Language(shortName: "tl", fullName: "тагальский"),
	                             Language(shortName: "tg", fullName: "таджикский"),
	                             Language(shortName: "th", fullName: "тайский"),
	                             Language(shortName: "ta", fullName: "тамильский"),
	                             Language(shortName: "tt", fullName: "татарский"),
	                             Language(shortName: "te", fullName: "телугу"),
	                             Languages.turkish,
	                             Language(shortName: "udm", fullName: "удмуртский"),
	                             Language(shortName: "uz", fullName: "узбекский"),
	                             Languages.turkish,
	                             Language(shortName: "ur", fullName: "урду"),
	                             Language(shortName: "fi", fullName: "финский"),
	                             Language(shortName: "fr", fullName: "французский"),
	                             Language(shortName: "hi", fullName: "хинди"),
	                             Language(shortName: "hr", fullName: "хорватский"),
	                             Language(shortName: "cs", fullName: "чешский"),
	                             Language(shortName: "sv", fullName: "шведский"),
	                             Language(shortName: "gd", fullName: "шотландский"),
	                             Language(shortName: "eo", fullName: "эсперанто"),
	                             Language(shortName: "et", fullName: "эстонский"),
	                             Language(shortName: "jv", fullName: "яванский"),
	                             Language(shortName: "ja", fullName: "японский")]

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
