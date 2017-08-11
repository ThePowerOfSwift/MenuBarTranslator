//
//  Language.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 11.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation


struct Language {
    
    let shortName: String!
    let fullName: String!
    
    init(shortName: String, fullName: String) {
        self.shortName = shortName
        self.fullName = fullName
    }
}

class Languages {
	var languages: [Language] = [Language(shortName: "az", fullName: "азербайджанский"),
		Language(shortName: "ml", fullName: "малаялам"),
		Language(shortName: "sq", fullName: "албанский"),
		Language(shortName: "mt", fullName: "мальтийский"),
		Language(shortName: "am", fullName: "амхарский"),
		Language(shortName: "mk", fullName: "македонский"),
		Language(shortName: "en", fullName: "английский"),
		Language(shortName: "mi", fullName: "маори"),
		Language(shortName: "ar", fullName: "арабский"),
		Language(shortName: "mr", fullName: "маратхи"),
		Language(shortName: "hy", fullName: "армянский"),
		Language(shortName: "mhr", fullName: "марийский"),
		Language(shortName: "af", fullName: "африкаанс"),
		Language(shortName: "mn", fullName: "монгольский"),
		Language(shortName: "eu", fullName: "баскский"),
		Language(shortName: "de", fullName: "немецкий"),
		Language(shortName: "ba", fullName: "башкирский"),
		Language(shortName: "ne", fullName: "непальский"),
		Language(shortName: "be", fullName: "белорусский"),
		Language(shortName: "no", fullName: "норвежский"),
		Language(shortName: "bn", fullName: "бенгальский"),
		Language(shortName: "pa", fullName: "панджаби"),
		Language(shortName: "my", fullName: "бирманский"),
		Language(shortName: "pap", fullName: "папьяменто"),
		Language(shortName: "bg", fullName: "болгарский"),
		Language(shortName: "fa", fullName: "персидский"),
		Language(shortName: "bs", fullName: "боснийский"),
		Language(shortName: "pl", fullName: "польский"),
		Language(shortName: "cy", fullName: "валлийский"),
		Language(shortName: "pt", fullName: "португальский"),
		Language(shortName: "hu", fullName: "венгерский"),
		Language(shortName: "ro", fullName: "румынский"),
		Language(shortName: "vi", fullName: "вьетнамский"),
		Language(shortName: "ru", fullName: "русский"),
		Language(shortName: "ht", fullName: "гаитянский (креольский)"),
		Language(shortName: "ceb", fullName: "себуанский"),
		Language(shortName: "gl", fullName: "галисийский"),
		Language(shortName: "sr", fullName: "сербский"),
		Language(shortName: "nl", fullName: "голландский"),
		Language(shortName: "si", fullName: "сингальский"),
		Language(shortName: "mrj", fullName: "горномарийский"),
		Language(shortName: "sk", fullName: "словацкий"),
		Language(shortName: "el", fullName: "греческий"),
		Language(shortName: "sl", fullName: "словенский"),
		Language(shortName: "ka", fullName: "грузинский"),
		Language(shortName: "sw", fullName: "суахили"),
		Language(shortName: "gu", fullName: "гуджарати"),
		Language(shortName: "su", fullName: "сунданский"),
		Language(shortName: "da", fullName: "датский"),
		Language(shortName: "tg", fullName: "таджикский"),
		Language(shortName: "he", fullName: "иврит"),
		Language(shortName: "th", fullName: "тайский"),
		Language(shortName: "yi", fullName: "идиш"),
		Language(shortName: "tl", fullName: "тагальский"),
		Language(shortName: "id", fullName: "индонезийский"),
		Language(shortName: "ta", fullName: "тамильский"),
		Language(shortName: "ga", fullName: "ирландский"),
		Language(shortName: "tt", fullName: "татарский"),
		Language(shortName: "it", fullName: "итальянский"),
		Language(shortName: "te", fullName: "телугу"),
		Language(shortName: "is", fullName: "исландский"),
		Language(shortName: "tr", fullName: "турецкий"),
		Language(shortName: "es", fullName: "испанский"),
		Language(shortName: "udm", fullName: "удмуртский"),
		Language(shortName: "kk", fullName: "казахский"),
		Language(shortName: "uz", fullName: "узбекский"),
		Language(shortName: "kn", fullName: "каннада"),
		Language(shortName: "uk", fullName: "украинский"),
		Language(shortName: "ca", fullName: "каталанский"),
		Language(shortName: "ur", fullName: "урду"),
		Language(shortName: "ky", fullName: "киргизский"),
		Language(shortName: "fi", fullName: "финский"),
		Language(shortName: "zh", fullName: "китайский"),
		Language(shortName: "fr", fullName: "французский"),
		Language(shortName: "ko", fullName: "корейский"),
		Language(shortName: "hi", fullName: "хинди"),
		Language(shortName: "xh", fullName: "коса"),
		Language(shortName: "hr", fullName: "хорватский"),
		Language(shortName: "km", fullName: "кхмерский"),
		Language(shortName: "cs", fullName: "чешский"),
		Language(shortName: "lo", fullName: "лаосский"),
		Language(shortName: "sv", fullName: "шведский"),
		Language(shortName: "la", fullName: "латынь"),
		Language(shortName: "gd", fullName: "шотландский"),
		Language(shortName: "lv", fullName: "латышский"),
		Language(shortName: "et", fullName: "эстонский"),
		Language(shortName: "lt", fullName: "литовский"),
		Language(shortName: "eo", fullName: "эсперанто"),
		Language(shortName: "lb", fullName: "люксембургский"),
		Language(shortName: "jv", fullName: "яванский"),
		Language(shortName: "mg", fullName: "малагасийский"),
		Language(shortName: "ja", fullName: "японский"),
		Language(shortName: "ms", fullName: "малайский")]

//    var languageDirections = [String: [String]]()
    var languageDirections = ["no": ["en", "ru"], "ca": ["en", "ru"], "cs": ["be", "en", "ru", "uk"], "sr": ["be", "ru", "uk"], "de": ["be", "en", "es", "fr", "it", "ru", "tr", "uk"], "sq": ["en", "ru"], "pl": ["be", "ru", "uk"], "lt": ["en", "ru"], "ro": ["be", "ru", "uk"], "et": ["en", "ru"], "hu": ["en", "ru"], "be": ["bg", "cs", "de", "en", "es", "fr", "it", "pl", "ro", "ru", "sr", "tr"], "ru": ["az", "be", "bg", "ca", "cs", "da", "de", "el", "en", "es", "et", "fi", "fr", "hr", "hu", "hy", "it", "lt", "lv", "mk", "nl", "no", "pl", "pt", "ro", "sk", "sl", "sq", "sr", "sv", "tr", "uk"], "sk": ["en", "ru"], "sv": ["en", "ru"], "hy": ["ru"], "da": ["en", "ru"], "fi": ["en", "ru"], "mk": ["en", "ru"], "uk": ["bg", "cs", "de", "en", "es", "fr", "it", "pl", "ro", "ru", "sr", "tr"], "el": ["en", "ru"], "en": ["be", "ca", "cs", "da", "de", "el", "es", "et", "fi", "fr", "hu", "it", "lt", "lv", "mk", "nl", "no", "pt", "ru", "sk", "sl", "sq", "sv", "tr", "uk"], "sl": ["en", "ru"], "es": ["be", "de", "en", "ru", "uk"], "pt": ["en", "ru"], "it": ["be", "de", "en", "ru", "uk"], "tr": ["be", "de", "en", "ru", "uk"], "nl": ["en", "ru"], "hr": ["ru"], "az": ["ru"], "bg": ["be", "ru", "uk"], "lv": ["en", "ru"], "fr": ["be", "de", "en", "ru", "uk"]]
    static var shared = Languages()
    
    func setLanguageDirections(directionsArray: [(String, String)]?) {
        guard let directions = directionsArray else {
            return
        }
        for direction in directions {
			if var array = languageDirections[direction.0] {
				array += [direction.1]
				languageDirections[direction.0] = array
			} else {
				languageDirections[direction.0] = [direction.1]
			}
        }
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
