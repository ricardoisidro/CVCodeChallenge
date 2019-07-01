//
//  NetworkRequest.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 6/28/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

protocol NetworkRequest {
    associatedtype LoadedType
    func load(then handler: @escaping (Result<LoadedType, LoadingError>) -> Void) -> RequestToken
    func decode(_ data: Data) throws -> LoadedType
}

extension NetworkRequest {
    
    @discardableResult
    func load(url: URL, then handler: @escaping (Result<LoadedType, LoadingError>) -> Void) -> RequestToken {
        let request = NSMutableURLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request as URLRequest) { (data: Data?, _: URLResponse?, error: Error?) in
            if error != nil {
                handler(Result.failure(.loadFail))
                return
            }
            guard let data = data else {
                handler(Result.failure(.nilData))
                return
            }
            do {
                let loadedType = try self.decode(data)
                handler(Result.success(loadedType))
            } catch {
                handler(Result.failure(.decodeFail))
            }
        }
        task.resume()
        return RequestToken(task: task)
    }
}
