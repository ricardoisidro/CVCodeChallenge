//
//  TableViewModelController+TableViewDelegate.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 6/28/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

extension TableViewModelController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableCellModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableCellModel[section].opened {
            return tableCellModel[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let maincell = tableView.dequeueReusableCell(withIdentifier: "header") else { return UITableViewCell() }
            return createHeader(using: maincell, in: indexPath)
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "information", for: indexPath) as? DetailTableViewCell {
                return createDetail(using: cell, in: indexPath)
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableCellModel[indexPath.section].opened {
                tableCellModel[indexPath.section].opened = false
            } else {
                tableCellModel[indexPath.section].opened = true
            }
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            if indexPath.section == 1 {
                delegate?.tableViewModelControllerDidSelectJob(self, didSelect: indexPath)
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TableSizes.Header.height
        } else {
            return TableSizes.Detail.height
        }
    }
}

private extension TableViewModelController {
    
    func createHeader(using cell: UITableViewCell, in index: IndexPath) -> UITableViewCell {
        cell.textLabel?.text = tableCellModel[index.section].cellTitle
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: TableSizes.Header.fontSize)
        return cell
    }
    
    func createDetail(using cell: DetailTableViewCell, in index: IndexPath) -> DetailTableViewCell {
        cell.title.text = tableCellModel[index.section].sectionData[index.row - 1].subCellTitle
        cell.title.font = UIFont.boldSystemFont(ofSize: TableSizes.Detail.fontSize)
        cell.detail.text = tableCellModel[index.section].sectionData[index.row - 1].subCellInformation
        cell.detail.font = UIFont.systemFont(ofSize: TableSizes.Detail.fontSize)
        return cell
    }
}
