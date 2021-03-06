//
//  DictionaryClient.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 04.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

class Dictionary { // singleton
	private init() {}

	static let shared = Dictionary()

	func translate(_ text: String, with direction: TranslateDirection, completionHandler: @escaping (String?) -> Void) {

		let requestor = RequestProcessor(request: Yandex.translate(text: text,
				direction: direction).request)
		requestor.makeCall(completion: { json, response, error in
			DispatchQueue.main.async {
				guard let json = json as? [String: Any],
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
				guard let json = json as? [String: Any],
					  let langsArray = json["dirs"] as? [String] else {
					print("fail languageDirections")
					completion(nil)
					return
				}
				var langArrayCouple = [(String, String)]()
				langsArray.forEach({
					let langs = $0.split(separator: "-").map(String.init)
					langArrayCouple.append((langs[0], langs[1]))
				})
				completion(langArrayCouple)
			}
		})
	}

	func languageDirections(_ completion: @escaping ([(String, String)]?) -> Void) {
		let requestor = RequestProcessor(request: Yandex.languages.request)
		requestor.makeCall(completion: { json, response, error in
			DispatchQueue.main.async {
				guard let json = json as? [String: Any],
					  let langsArray = json["dirs"] as? [String] else {
					print("fail languageDirections")
					completion(nil)
					return
				}
				var langArrayCouple = [(String, String)]()
				langsArray.forEach({
					let langs = $0.split(separator: "-").map(String.init)
					langArrayCouple.append((langs[0], langs[1]))
				})
				completion(langArrayCouple)
			}
		})
	}

	func detectLanguage(by text: String, completion: @escaping (String?) -> Void) {
		let requestor = RequestProcessor(request: Yandex.detectLanguage(text: text).request)
		requestor.makeCall(completion: { json, response, error in
			DispatchQueue.main.async {
				guard let json = json as? [String: Any],
					  let lang = json["lang"] as? String else {
					print("fail detectLanguage")
					completion(nil)
					return
				}
				completion(lang)
			}
		})
	}

	func pronounce(text: String, for language: Language, completion: @escaping ((URL) -> Void)) {
		let requestor = RequestProcessor(request: Yandex.pronounce(text: text, language: language).request)

		requestor.getData { (url, _, _) in
			guard let url = url else {
				return
			}

			completion(url)
		}
	}

}
