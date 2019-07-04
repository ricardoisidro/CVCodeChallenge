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
            if indexPath.section == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as? DetailTableViewCell {
                    return createDetail(using: cell, in: indexPath)
                } else {
                    return UITableViewCell()
                }
            } else if indexPath.section == 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath) as? DetailTableViewCell {
                    return createDetail(using: cell, in: indexPath)
                } else {
                    return UITableViewCell()
                }
            }
            else if indexPath.section == 2 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "job", for: indexPath) as? DetailTableViewCell {
                    return createDetail(using: cell, in: indexPath)
                } else {
                    return UITableViewCell()
                }
            } else if indexPath.section == 3 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "skill", for: indexPath) as? DetailTableViewCell {
                    return createDetail(using: cell, in: indexPath)
                } else {
                    return UITableViewCell()
                }
            } else if indexPath.section == 4 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "education", for: indexPath) as? DetailTableViewCell {
                    return createDetail(using: cell, in: indexPath)
                } else {
                    return UITableViewCell()
                }
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
            if indexPath.section == 2 {
                fillExperienceArrays()
            } else if indexPath.section == 3 {
                fillSkillsArrays()
            } else if indexPath.section == 4 {
                fillSchoolsArrays()
            }
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            if indexPath.section == 2 {
                updateCellsExperience()
            } else if indexPath.section == 3 {
                updateCellsSkills()
            } else if indexPath.section == 4 {
                updateCellsSchools()
            }
            updateCells()
        } else {
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
    
    func createDetail(using cell: DetailTableViewCell, in index: IndexPath) ->
        DetailTableViewCell {
            switch index.section {
            case 0:
                cell.title.text = tableCellModel[index.section].sectionData[index.row - 1].subCellTitle
                switch index.row {
                case 1:
                    cell.detail.bind(to: name)
                case 2:
                    cell.detail.bind(to: surname)
                case 3:
                    cell.detail.bind(to: age)
                case 4:
                    cell.detail.bind(to: nationality)
                default:
                    break
                }
            case 1:
                cell.title.text = tableCellModel[index.section].sectionData[index.row - 1].subCellTitle
                switch index.row {
                case 1:
                    cell.detail.bind(to: mail)
                case 2:
                    cell.detail.bind(to: phone)
                case 3:
                    cell.detail.bind(to: webpage)
                default:
                    break
                }
            case 2:
                cell.title.bind(to: jobs[index.row - 1].job)
                cell.detail.bind(to: jobs[index.row - 1].place)
            case 3:
                cell.detail.bind(to: skills[index.row - 1].skill)
            case 4:
                cell.title.bind(to: schools[index.row - 1].degree)
                cell.detail.bind(to: schools[index.row - 1].period)
           default:
                break
            }
        cell.title.font = UIFont.boldSystemFont(ofSize: TableSizes.Detail.fontSize)
        cell.detail.font = UIFont.systemFont(ofSize: TableSizes.Detail.fontSize)
        return cell
    }
}
