//
//  Request.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 05.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

class Request {
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
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error.debugDescription)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response.debugDescription)")
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    print("responseString = \(json)")
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
        
        
    }
}


private func bodyString(withParams params: [String: String]) -> String {
    var body = String()
    for var pair in params {
        body += "\(pair.key)=\(pair.value)&"
    }
    if(body.characters.count != 0){
        body.characters.removeLast()
    }
    return body
}
