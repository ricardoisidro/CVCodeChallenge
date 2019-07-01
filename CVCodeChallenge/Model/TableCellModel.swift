//
//  TableCellModel.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 7/1/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

struct TableCellModel {
    var opened: Bool
    var cellTitle: String
    var sectionData: [SectionData]
}

struct SectionData {
    var subCellTitle: String
    var subCellInformation: String
}
