//
//  RequestClient.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 05.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

class RequestClient {
    enum Method : String {
        case POST
        case GET
    }
    var request : URLRequest!
    var session : URLSession?
    var url: URL!
    var params = [String: String]()
    
    init(URL baseUrl: String) {
        self.url = URL(string: baseUrl)
        request = URLRequest(url: url)
    }
    
    func addParam (byKey key: String, withValue value: String) {
        params[key] = value
    }
    
    func makeCall (method: Method, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void){
        request.httpBody = bodyString(withParams: params).data(using: .utf8)
        request.httpMethod = method.rawValue
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    success(data , response , error as NSError?)
                } else {
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                }
            } else {
                failure(data , response as? HTTPURLResponse, error as NSError?)
                
            }
        }
        task.resume()
    }
    
}


private func bodyString(withParams params: [String: String]) -> String {
    var body = String()
    for pair in params {
        body += "\(pair.key)=\(pair.value)&"
    }
    if(body.characters.count != 0){
        body.characters.removeLast()
    }
    return body
}
