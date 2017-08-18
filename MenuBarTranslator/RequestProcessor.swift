//
//  RequestProcessor.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 05.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

class RequestProcessor {
    
    typealias JSONObject = Any
    typealias JSONHandler = (JSONObject?, HTTPURLResponse?, Error?) -> Void

    var request : URLRequest!
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    init(request: URLRequest) {
        self.request = request
    }
    
    func makeCall (completion: @escaping JSONHandler){
        let task = session.dataTask(with: self.request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil, error as Error?)
                return
            }
            if let data = data {
                if 200...299 ~= httpResponse.statusCode{
                    do {
						if let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSONObject {
							completion(json, httpResponse, nil)
						}

                    } catch let error as NSError {
                        completion(nil, httpResponse, error)
                    }
                }
                else {
					completion(nil, httpResponse, error)
//                    print("Received HTTP response code: \(httpResponse.statusCode)")
                }
            } else {
                if let error = error {
                    completion(nil, httpResponse, error)
                }
            }
            
        }
        task.resume()
    }
}
