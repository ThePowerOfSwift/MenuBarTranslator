//
//  WordnikEndPoint.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 16.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation


enum Datamuse {
	case suggested(word: String)

	var request: URLRequest {
		var components = URLComponents(string: baseUrl)!
		components.path += path
		components.queryItems = queryComponents

		let url = components.url!
		return URLRequest(url: url)
	}

	private var baseUrl : String {
		return "https://api.datamuse.com"
	}

	struct DefaultValues {
		static let maximumValues = 7
	}

	private var path : String {
		return "/words"
	}



	private struct ParameterKeys {
		static let spelledLike = "sp"
		static let maximumValues = "max"
	}

	private var parameters: [String : Any] {
		switch self {
		case .suggested(let word):
			let parameters: [String : Any] = [
				ParameterKeys.spelledLike: "\(word)*",
				ParameterKeys.maximumValues: DefaultValues.maximumValues
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
