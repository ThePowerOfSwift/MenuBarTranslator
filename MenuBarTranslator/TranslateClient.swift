//
//  TranslateClient.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 04.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation


class TranslateClient {
    
    private let API_KEY = "trnsl.1.1.20170804T195228Z.43cbafd05327100f.0b80728653b33567b49b4c25d39b50a6f4b18127"
    private let BASE_URL = "https://translate.yandex.net/api/v1.5/tr.json/translate"
    
    func translateText(_ text: String, fromLanguage from: String = "", toLanguage to: String, completionHandler:@escaping (String)->Void) {
        let requestor = RequestClient(URL: BASE_URL)
        requestor.addParam(byKey: "key", withValue: API_KEY)
        requestor.addParam(byKey: "text", withValue: text)
        requestor.addParam(byKey: "lang", withValue: from + to)
        var translatedText = text
        
        requestor.makeCall(method: .POST,
                           success: { (data, response, error) in
                                    do {
                                        if let data = data,
                                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject],
                                        let translatedArray = json["text"] as? [Any] {
                                            if let translated = translatedArray[0] as? String {
                                                translatedText = translated
                                                
                                            }
                                        }
                                    } catch let error {
                                        print(error.localizedDescription)
                                    }
                                completionHandler(translatedText)
                            },
                           failure: { (data, response, error) in
                                completionHandler(text)
                            })
    }

}
