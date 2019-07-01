//
//  ApiResource.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 7/1/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

protocol ApiResource {
    associatedtype Model
    var url: URL { get }
    func makeModel(fromData data: Data) throws -> Model
}
