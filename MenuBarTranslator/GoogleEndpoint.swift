//
//  GoogleEndpoint.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 16.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation


enum Google {
	case suggested(word: String)

	var request: URLRequest {
		var components = URLComponents(string: baseUrl)!
		components.path += path
		components.queryItems = queryComponents

		let url = components.url!
		print(url)
		return URLRequest(url: url)
	}

	private var baseUrl : String {
		return "https://suggestqueries.google.com"
	}

	struct DefaultValues {
		static let client = "firefox"
	}

	private var path : String {
		switch self {
		case .suggested:
			return "/complete/search"
		}
	}



	private struct ParameterKeys {
		static let query = "q"
		static let client = "client"
	}

	private var parameters: [String : Any] {
		switch self {
		case .suggested(let word):
			let parameters: [String : Any] = [
				ParameterKeys.query: word,
				ParameterKeys.client: DefaultValues.client
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
