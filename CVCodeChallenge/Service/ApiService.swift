//
//  ApiService.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 6/28/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

struct ApiService {
    
    typealias UserInformationHandler = (Result<CVInformation.CodingData, LoadingError>) -> Void
    
    func loadInformation(then handler: @escaping UserInformationHandler) {
        let request = ApiRequest(resource: CVResource())
        request.load(then: handler)
    }
}
