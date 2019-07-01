//
//  ApiRequest.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 6/28/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

struct ApiRequest<Resource: ApiResource> {
    let resource: Resource
}

extension ApiRequest: NetworkRequest {
    
    typealias LoadedType = Resource.Model
    
    @discardableResult
    func load(then handler: @escaping (Result<LoadedType, LoadingError>) -> Void) -> RequestToken {
        return self.load(url: resource.url, then: handler)
    }
    
    func decode(_ data: Data) throws -> Resource.Model {
        return try resource.makeModel(fromData: data)
    }
}
