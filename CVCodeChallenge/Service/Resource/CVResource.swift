//
//  CVResource.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 7/1/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

class CVResource: ApiResource {
    
    typealias Model = CVInformation.CodingData
    var url: URL
    
    init() {
        var components = URLComponents()
        components.scheme = Environment.rootScheme
        components.host = Environment.rootHost
        components.path = Environment.rootPath
        guard let url = components.url else { fatalError("url not valid") }
        self.url = url
    }
    
    func makeModel(fromData data: Data) throws -> Model {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Model.self, from: data)
    }
}
