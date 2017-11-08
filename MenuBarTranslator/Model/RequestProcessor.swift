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
	typealias DataHandler = (URL?, URLResponse?, Error?) -> Void

	var request : URLRequest
	let session: URLSession = URLSession(configuration: .default)

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
						let json = try JSONSerialization.jsonObject(with: data, options: []) as JSONObject
						completion(json, httpResponse, nil)
					} catch let error as NSError {
						completion(nil, httpResponse, error)
					}
				}
				else {
					completion(nil, httpResponse, error)
				}
			} else {
				if let error = error {
					completion(nil, httpResponse, error)
				}
			}

		}
		task.resume()
	}

	func getData(completion: @escaping DataHandler) {
		guard let url = request.url else {
			completion(nil, nil, nil)
			return
		}
		let task = session.downloadTask(with: url) { (url, response, error) in
			guard let response = response as? HTTPURLResponse else {
				completion(nil, nil, error as Error?)
				return
			}
			if let url = url {
				if 200...299 ~= response.statusCode {
					do {
						let time = NSNumber(value:(NSDate().timeIntervalSince1970 * 1000))
						let fileName = NSString(format:"%@_music.mp3", time)

						let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
						let location = documentsUrl.appendingPathComponent(fileName as String)
						try FileManager.default.copyItem(at: url, to: location)
						completion(location, response, error)
						completion(url, response, error)
					} catch let error as NSError {
						completion(nil, response, error)
					}

				} else {
					completion(nil, response, error)
				}
			} else {
				if let error = error {
					completion(nil, response, error)
				}
			}

		}
		task.resume()
	}

}
