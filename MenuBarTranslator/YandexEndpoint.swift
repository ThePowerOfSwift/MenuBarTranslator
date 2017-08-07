//
//  YandexEndpoint.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 07.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

enum YandexEndpoint {
    case translate(text: String, lang: String)
    
    case languages
    
    var request: URLRequest {
        var components = URLComponents(string: baseUrl)!
        components.path += path
        components.queryItems = queryComponents
        
        let url = components.url!
        return URLRequest(url: url)
    }
    
    private var baseUrl : String {
        return "https://translate.yandex.net/api/v1.5/tr.json"
    }
    
    private var keyAPI : String {
        return "trnsl.1.1.20170804T195228Z.43cbafd05327100f.0b80728653b33567b49b4c25d39b50a6f4b18127"
    }
    
    private var path : String {
        switch self {
            case .translate:
                return "/translate"
            case .languages:
                return "/getLangs"
        }
    }
    
    private struct ParameterKeys {
        static var key = "key"
        static let text = "text"
        static let lang = "lang"
    }
    
    
    private var parameters: [String : Any] {
        switch self {
            case .translate(let text, let lang):
                let parameters: [String : Any] = [
                    ParameterKeys.key: keyAPI,
                    ParameterKeys.text: text,
                    ParameterKeys.lang: lang
                ]
            
                return parameters
            case .languages:
                let parameters: [String: Any] = [
                    ParameterKeys.key: keyAPI
                ]
                return parameters
        }
    }
    
    private var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        return components
    }
}
