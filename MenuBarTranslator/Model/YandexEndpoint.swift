//
//  YandexEndpoint.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 07.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

enum Yandex {
    case translate(text: String, language: String)
    
    case languages
    
    case detectLanguage(text: String)

	case pronounce(text: String, language: Language)

    var request: URLRequest {
        var components = URLComponents(string: baseUrl)!
        components.path += path
        components.queryItems = queryComponents
        
        let url = components.url!
        return URLRequest(url: url)
    }
    
    private var baseUrl : String {
		switch self {
			case .pronounce:
				return "https://tts.voicetech.yandex.net"
			default:
				return "https://translate.yandex.net/api/v1.5/tr.json"

		}
    }
    
    private var translateKeyAPI : String {
        return Key.translate
    }

	private var speechKeyAPI:  String {
		return Key.speech
	}
    
    private var path : String {
        switch self {
            case .translate:
                return "/translate"
            case .languages:
                return "/getLangs"
            case .detectLanguage:
                return "/detect"
			case .pronounce:
				return "/generate"
        }
    }
    
    private struct ParameterKeys {
        static let key = "key"
        static let text = "text"
        static let language = "lang"
		static let speaker = "speaker"
		static let format = "format"
    }
    
    private var parameters: [String : Any] {
        switch self {
            case .translate(let text, let language):
                let parameters: [String : Any] = [
                    ParameterKeys.key: translateKeyAPI,
                    ParameterKeys.text: text,
                    ParameterKeys.language: language
                ]
            
                return parameters
            case .languages:
                let parameters: [String: Any] = [
                    ParameterKeys.key: translateKeyAPI
                ]
                return parameters
            case .detectLanguage(let text):
                let parameters: [String : Any] = [
                    ParameterKeys.key: translateKeyAPI,
                    ParameterKeys.text: text
                ]
                return parameters
			case .pronounce(let text, let language):
				let parameters: [String : Any] = [
					ParameterKeys.key: speechKeyAPI,
					ParameterKeys.text: text,
					ParameterKeys.format: "mp3",
					ParameterKeys.language: "\(language.shortName)-\(language.shortName.uppercased())",
					ParameterKeys.speaker: "oksana"
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
