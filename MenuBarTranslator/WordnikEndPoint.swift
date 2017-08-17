//
//  WordnikEndPoint.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 16.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation


enum Wordnik {
	case suggested(word: String)

	var request: URLRequest {
		var components = URLComponents(string: baseUrl)!
		components.path += path
		components.queryItems = queryComponents

		let url = components.url!
		return URLRequest(url: url)
	}

	private var baseUrl : String {
		return "https://api.wordnik.com"
	}

	struct DefaultValues {
		static let caseSensitive = true
		static let maxDictionaryCount = 5
		static let minLength = 4
		static let skip = 1
		static let apiKey = "034ba2f1cb3f05e1a400e0cb55a0065c484341a398f9b3bb4"
		static let limit = 5
	}

	private var path : String {
		switch self {
		case .suggested(let word):
			return "/v4/words.json/search/\(word)"
		}
	}



	private struct ParameterKeys {
		static let caseSensitive = "caseSensitive"
		static let maxDictionaryCount = "maxDictionaryCount"
		static let minLength = "minLength"
		static let skip = "skip"
		static let apiKey = "api_key"
		static let limit = "limit"
	}

	private var parameters: [String : Any] {
		switch self {
		case .suggested:
			let parameters: [String : Any] = [
				ParameterKeys.caseSensitive: DefaultValues.caseSensitive,
				ParameterKeys.maxDictionaryCount: DefaultValues.maxDictionaryCount,
				ParameterKeys.minLength: DefaultValues.minLength,
				ParameterKeys.skip: DefaultValues.skip,
				ParameterKeys.limit: DefaultValues.limit,
				ParameterKeys.apiKey: DefaultValues.apiKey
				]
			return parameters
		}
	}

	private var queryComponents: [URLQueryItem] {
		var components = [URLQueryItem]()
		parameters.forEach({
			let queryItem = URLQueryItem(name: $0, value: "\($1)")
			components.append(queryItem)
		})
		return components
	}
}
