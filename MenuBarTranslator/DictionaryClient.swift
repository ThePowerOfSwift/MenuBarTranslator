//
//  DictionaryClient.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 04.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation


class Dictionary {
	private init() { }

	static let shared = Dictionary()

	func translate(_ text: String, from: Language?, to: Language, completionHandler:@escaping (String?) -> Void) {
		var languageDirection: String
		if let from = from {
			languageDirection = "\(from.shortName)-\(to.shortName)"
		} else {
			languageDirection = to.shortName
		}

		let requestor = RequestProcessor(request: Yandex.translate(text: text,
		                                                           lang: languageDirection).request)
		requestor.makeCall(completion: { json, response, error in
			DispatchQueue.main.async {
				guard let json = json,
					let translatedArray = json["text"] as? [Any],
					let translatedText = translatedArray[0] as? String else {
						completionHandler(nil)
						return
				}
				completionHandler(translatedText)
			}
		})
	}

	func languageDirections(completion: @escaping ([(String, String)]?) -> Void) {
		let requestor = RequestProcessor(request: Yandex.languages.request)
		requestor.makeCall(completion: { json, response, error in
			DispatchQueue.main.async {
				guard let json = json,
					let langsArray = json["dirs"] as? [String] else {
						completion(nil)
						return
				}
				var langArrayCouple  = [(String, String)]()
				langsArray.forEach({
					let langs =  $0.characters.split(separator: "-").map(String.init)
					langArrayCouple.append(langs[0], langs[1])
				})
				completion(langArrayCouple)
			}
		})
	}

	func detectLanguage(byText text: String, completion: @escaping (String?) -> Void) {
		let requestor = RequestProcessor(request: Yandex.detectLanguage(text: text).request)
		requestor.makeCall(completion: { json, response, error in
			DispatchQueue.main.async {
				guard let json = json,
					let lang = json["lang"] as? String else {
						completion(nil)
						return
				}
				completion(lang)
			}
		})
	}


	func suggest(toWord word: String, completion: @escaping ([String]?) -> Void) {
		let requestor = RequestProcessor(request: Wordnik.suggested(word: word).request)
		requestor.makeCall(completion: { json, response, error in
			DispatchQueue.main.async {
				guard let json = json,
				let jsonArray = json["searchResults"] as? [Any] else {
					completion(nil)
					return
				}
				var suggestedWords = [String]()
				for object in jsonArray {
					if let wordObject = object as? [String: Any],
						let word = wordObject["word"] as? String{
						suggestedWords.append(word)
					}
				}
				completion(suggestedWords)
			}
		})
	}

}
