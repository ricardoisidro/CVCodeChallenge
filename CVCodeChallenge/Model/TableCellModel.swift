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
