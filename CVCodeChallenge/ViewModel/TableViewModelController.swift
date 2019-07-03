//
//  TableViewModelController.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 6/28/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

protocol TableViewModelControllerDelegate: class {
    func tableViewModelControllerDidFinishLoadInformation(_ tableViewModelController: TableViewModelController)
    func tableViewModelControllerDidSelectJob(_ tableViewModelController: TableViewModelController, didSelect: IndexPath)
}

class TableViewModelController: NSObject {
    
    var tableCellModel = [TableCellModel]()
    private var skillsTable = [SectionData]()
    private var jobsTable = [SectionData]()
    
    weak var delegate: TableViewModelControllerDelegate?
    
    typealias CVData = CVInformation.CodingData
    
    func fill() {
        ApiService().loadInformation { (result: Result<CVData, LoadingError>) in
            switch result {
            case .success(let response):
                self.fillTable(with: response)
                break
            case .failure:
                print("Error filling the table")
            }
        }
    }
}

private extension TableViewModelController {
    
    func fillTable(with information: CVData) {
        tableCellModel.append(TableCellModel(opened: false,
                                                  cellTitle: NSLocalizedString("ProfileTitle", comment: ""),
                                                  sectionData: [SectionData(subCellTitle: NSLocalizedString("ProfileName", comment: ""), subCellInformation: information.info.name + " " + information.info.surnames), SectionData(subCellTitle: NSLocalizedString("ProfileAge", comment: ""), subCellInformation: information.info.age), SectionData(subCellTitle: NSLocalizedString("ProfileNationality", comment: ""), subCellInformation: information.info.nationality)]))
        for employee in information.experience {
            jobsTable.append(SectionData(subCellTitle: employee.place, subCellInformation: employee.job))
        }
        tableCellModel.append(TableCellModel(opened: false,
                                                  cellTitle: NSLocalizedString("JobsTitle", comment: ""),
                                                  sectionData: jobsTable))
        for element in information.skills {
            skillsTable.append(SectionData(subCellTitle: "", subCellInformation: element.skill))
        }
        tableCellModel.append(TableCellModel(opened: false,
                                                  cellTitle: NSLocalizedString("SkillsTitle", comment: ""),
                                                  sectionData: skillsTable))
        delegate?.tableViewModelControllerDidFinishLoadInformation(self)
    }
}
