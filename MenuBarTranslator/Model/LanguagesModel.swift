//
//  LanguagesModel.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 19.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

struct Languages {

	static let english = Language(shortName: "en", fullName: "English", isPronunciationAvailable: true)
	static let russian = Language(shortName: "ru", fullName: "Russian", isPronunciationAvailable: true)
	static let turkish = Language(shortName: "tr", fullName: "Turkish", isPronunciationAvailable: true)
	static let urkanian = Language(shortName: "uk", fullName: "Ukrainian", isPronunciationAvailable: true)
	static let auto = Language(shortName: "auto", fullName: "Automatically")
	static let standart = [english, russian, auto]

	static var languages: [Language] = [Languages.auto,
										Language(shortName: "az", fullName: "Azerbaijani"),
										Language(shortName: "sq", fullName: "Albanian"),
										Languages.english,
										Language(shortName: "hy", fullName: "Armenian"),
										Language(shortName: "af", fullName: "Afrikaans"),
										Language(shortName: "eu", fullName: "Basque"),
										Language(shortName: "be", fullName: "Belarusian"),
										Language(shortName: "bn", fullName: "Bengali"),
										Language(shortName: "my", fullName: "Burmese"),
										Language(shortName: "bg", fullName: "Bulgarian"),
										Language(shortName: "bs", fullName: "Bosnian"),
										Language(shortName: "cy", fullName: "Welsh"),
										Language(shortName: "hu", fullName: "Hungarian"),
										Language(shortName: "vi", fullName: "Vietnamese"),
										Language(shortName: "ht", fullName: "Haitian"),
										Language(shortName: "nl", fullName: "Dutch"),
										Language(shortName: "el", fullName: "Greek"),
										Language(shortName: "ka", fullName: "Georgian"),
										Language(shortName: "gu", fullName: "Gujarati"),
										Language(shortName: "da", fullName: "Danish"),
										Language(shortName: "he", fullName: "Hebrew"),
										Language(shortName: "yi", fullName: "Yiddish"),
										Language(shortName: "id", fullName: "Indonesian"),
										Language(shortName: "ga", fullName: "Irish"),
										Language(shortName: "is", fullName: "Icelandic"),
										Language(shortName: "es", fullName: "Spanish"),
										Language(shortName: "it", fullName: "Italian"),
										Language(shortName: "kk", fullName: "Kazakh"),
										Language(shortName: "kn", fullName: "Kannada"),
										Language(shortName: "ky", fullName: "Kyrgyz"),
										Language(shortName: "zh", fullName: "Chinese"),
										Language(shortName: "ko", fullName: "Korean"),
										Language(shortName: "xh", fullName: "Spit"),
										Language(shortName: "lo", fullName: "Laotian"),
										Language(shortName: "lv", fullName: "Latvian"),
										Language(shortName: "lt", fullName: "Lithuanian"),
										Language(shortName: "lb", fullName: "Luxembourgish"),
										Language(shortName: "mk", fullName: "Macedonian"),
										Language(shortName: "ms", fullName: "Malay"),
										Language(shortName: "ml", fullName: "Malayalam"),
										Language(shortName: "mt", fullName: "Maltese"),
										Language(shortName: "mr", fullName: "Marathi"),
										Language(shortName: "mn", fullName: "Mongolian"),
										Language(shortName: "de", fullName: "German"),
										Language(shortName: "ne", fullName: "Nepali"),
										Language(shortName: "no", fullName: "Norwegian"),
										Language(shortName: "pa", fullName: "Punjabi"),
										Language(shortName: "pl", fullName: "Polish"),
										Language(shortName: "pt", fullName: "Portuguese"),
										Language(shortName: "ro", fullName: "Romanian"),
										Languages.russian,
										Language(shortName: "sr", fullName: "Serbian"),
										Language(shortName: "sk", fullName: "Slovak"),
										Language(shortName: "sl", fullName: "Slovenian"),
										Language(shortName: "su", fullName: "Sundansky"),
										Language(shortName: "tg", fullName: "Tajik"),
										Language(shortName: "th", fullName: "Thai"),
										Language(shortName: "te", fullName: "Telugu"),
										Languages.turkish,
										Languages.urkanian,
										Language(shortName: "uz", fullName: "Uzbek"),
										Language(shortName: "ur", fullName: "Urdu"),
										Language(shortName: "fi", fullName: "Finnish"),
										Language(shortName: "fr", fullName: "French"),
										Language(shortName: "hi", fullName: "Hindi"),
										Language(shortName: "hr", fullName: "Croatian"),
										Language(shortName: "cs", fullName: "Czech"),
										Language(shortName: "sv", fullName: "Swedish"),
										Language(shortName: "gd", fullName: "Scottish"),
										Language(shortName: "et", fullName: "Estonian"),
										Language(shortName: "jv", fullName: "Java"),
										Language(shortName: "ja", fullName: "Japanese")]

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

	static func isDirectionExists(fromLanguage from: String, toLanguage to: String) -> Bool {
		if let array = languageDirections[from] {
			return array.contains(to)
		}
		return false
	}


	static func searchLanguage(by shortName: String) -> Language? {
		return Languages.languages.filter({ $0.shortName == shortName }).first
	}
}
