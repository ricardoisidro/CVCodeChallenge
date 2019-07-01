//
//  LoadingError.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 7/1/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

enum LoadingError: Error {
    case loadFail
    case nilData
    case decodeFail
}
