//
//  Language.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 11.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation


struct Language: Equatable {

	let shortName: String!
	let fullName: String!

	init(shortName: String, fullName: String) {
		self.shortName = shortName
		self.fullName = fullName
	}

	static func ==(lang1: Language, lang2: Language) -> Bool {
		return lang1.fullName == lang2.fullName && lang2.shortName == lang1.shortName
	}
}

class Languages {

	static var StandartLanguages: [Language] {
		let english = Language(shortName: "en", fullName: "английский")
		let russian = Language(shortName: "ru", fullName: "русский")
		let german = Language(shortName: "de", fullName: "немецкий")

		return [english, russian, german]
	}

	var languages: [Language] = [Language(shortName: "az", fullName: "азербайджанский"),
	                             Language(shortName: "sq", fullName: "албанский"),
	                             Language(shortName: "am", fullName: "амхарский"),
	                             Language(shortName: "en", fullName: "английский"),
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
	                             Language(shortName: "ht", fullName: "гаитянский (креольский)"),
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
	                             Language(shortName: "ru", fullName: "русский"),
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
	                             Language(shortName: "tr", fullName: "турецкий"),
	                             Language(shortName: "udm", fullName: "удмуртский"),
	                             Language(shortName: "uz", fullName: "узбекский"),
	                             Language(shortName: "uk", fullName: "украинский"),
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

	//    var languageDirections = [String: [String]]()
	var languageDirections = ["no": ["en", "ru"], "ca": ["en", "ru"], "cs": ["be", "en", "ru", "uk"], "sr": ["be", "ru", "uk"], "de": ["be", "en", "es", "fr", "it", "ru", "tr", "uk"], "sq": ["en", "ru"], "pl": ["be", "ru", "uk"], "lt": ["en", "ru"], "ro": ["be", "ru", "uk"], "et": ["en", "ru"], "hu": ["en", "ru"], "be": ["bg", "cs", "de", "en", "es", "fr", "it", "pl", "ro", "ru", "sr", "tr"], "ru": ["az", "be", "bg", "ca", "cs", "da", "de", "el", "en", "es", "et", "fi", "fr", "hr", "hu", "hy", "it", "lt", "lv", "mk", "nl", "no", "pl", "pt", "ro", "sk", "sl", "sq", "sr", "sv", "tr", "uk"], "sk": ["en", "ru"], "sv": ["en", "ru"], "hy": ["ru"], "da": ["en", "ru"], "fi": ["en", "ru"], "mk": ["en", "ru"], "uk": ["bg", "cs", "de", "en", "es", "fr", "it", "pl", "ro", "ru", "sr", "tr"], "el": ["en", "ru"], "en": ["be", "ca", "cs", "da", "de", "el", "es", "et", "fi", "fr", "hu", "it", "lt", "lv", "mk", "nl", "no", "pt", "ru", "sk", "sl", "sq", "sv", "tr", "uk"], "sl": ["en", "ru"], "es": ["be", "de", "en", "ru", "uk"], "pt": ["en", "ru"], "it": ["be", "de", "en", "ru", "uk"], "tr": ["be", "de", "en", "ru", "uk"], "nl": ["en", "ru"], "hr": ["ru"], "az": ["ru"], "bg": ["be", "ru", "uk"], "lv": ["en", "ru"], "fr": ["be", "de", "en", "ru", "uk"]]
	static var shared = Languages()



	func setLanguageDirections(directionsArray: [(String, String)]?) {
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


	func add(language: Language) {
		languages.append(language)
	}

	func searchLanguage(byFullName fullName: String) -> String? {
		for language in languages {
			if language.fullName == fullName {
				return language.shortName
			}
		}
		return nil
	}

	func isDirectionExists(fromLanguage from: String, toLanguage to: String) -> Bool {
		if let array = languageDirections[from] {
			return array.contains(to)
		}
		return false
	}


	func searchLanguage(byShortName shortName: String) -> String? {
		
		for language in languages {
			if language.shortName == shortName {
				return language.fullName
			}
		}
		return nil
	}
}
