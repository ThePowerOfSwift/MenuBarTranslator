//
//  TranslateAPI.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 04.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation


class Translator {
    
    static private let API_KEY = "trnsl.1.1.20170804T195228Z.43cbafd05327100f.0b80728653b33567b49b4c25d39b50a6f4b18127"
    static private let BASE_URL = "https://translate.yandex.net/api/v1.5/tr.json/translate"
    
    
    static func translateText(_ text: String, fromLanguage from: String = "", toLanguage to: String) {
        var requestor = Request(URL: BASE_URL)
        requestor.addParam(byKey: "key", withValue: API_KEY)
        requestor.addParam(byKey: "text", withValue: text)
        requestor.addParam(byKey: "lang", withValue: from + to)
        
        requestor.makeCall(method: .POST,
                           success: { (data, response, error) in
                            Swift.print("Yes")
        },
                           failure: { (data, response, error) in
                            Swift.print("---Error---")
        })
    }
}
