import UIKit

class TableViewModelController: NSObject, TableViewModelProtocol {
    
    // MARK: - Variables
    var cvInformation: CVInformation.CodingData?
    
    var completeDidLoad: (() -> ()) = { }
    
    var tableCellModel = [TableCellModel]()
    private var skillsTable = [SectionData]()
    private var jobsTable = [SectionData]()
    private var schoolsTable = [SectionData]()
    
    var name: CVObservable<String> = CVObservable("")
    var surname: CVObservable<String> = CVObservable("")
    var age: CVObservable<Int> = CVObservable(0)
    var nationality: CVObservable<String> = CVObservable("")
    
    var mail: CVObservable<String> = CVObservable("")
    var phone: CVObservable<String> = CVObservable("")
    var webpage: CVObservable<String> = CVObservable("")
    
    var school: CVObservable<String> = CVObservable("")
    var degree: CVObservable<String> = CVObservable("")
    var period: CVObservable<String> = CVObservable("")
    
    var jobs: [JobsGroup] = [JobsGroup]()
    var skills: [SkillsGroup] = [SkillsGroup]()
    var schools: [SchoolGroup] = [SchoolGroup]()
        
    // MARK: - Functions

    func fill() {
        ApiService().loadInformation { (result: Result<CVInformation.CodingData, LoadingError>) in
            switch result {
            case .success(let response):
                self.cvInformation = response
                self.fillTable()
                break
            case .failure:
                print("Error")
            }
        }
    }
    
    func updateCells() {
        name.value = cvInformation?.info.name
        surname.value = cvInformation?.info.surnames
        age.value = cvInformation?.info.age
        nationality.value = cvInformation?.info.nationality
        mail.value = cvInformation?.contact.mail
        phone.value = cvInformation?.contact.phone
        webpage.value = cvInformation?.contact.webpage
    }
    
    func updateCellsExperience() {
        guard let experiences = cvInformation?.experience else { return }
        for (index, value) in experiences.enumerated() {
            jobs[index].job.value = value.job
            jobs[index].place.value = value.place
        }
    }
    
    func updateCellsSkills() {
        guard let technologies = cvInformation?.skills else { return }
        for (index, value) in technologies.enumerated() {
            skills[index].skill.value = value.skill
        }
    }
    
    func updateCellsSchools() {
        guard let institutes = cvInformation?.education else { return }
        for (index, value) in institutes.enumerated() {
            schools[index].degree.value = value.degree
            schools[index].period.value = value.period
        }
    }
    
    func fillExperienceArrays() {
        cvInformation?.experience.forEach { experience in
            jobs.append(JobsGroup())
        }
    }
    
    func fillSkillsArrays() {
        cvInformation?.skills.forEach { skill in
            skills.append(SkillsGroup())
        }
    }
    
    func fillSchoolsArrays() {
        cvInformation?.education.forEach { skill in
            schools.append(SchoolGroup())
        }
    }
    
    private func fillTable() {
        
        let nameCell = SectionData(subCellTitle: NSLocalizedString("ProfileName", comment: ""), subCellInformation: "")
        let surnameCell = SectionData(subCellTitle: NSLocalizedString("ProfileSurname", comment: ""), subCellInformation: "")
        let ageCell = SectionData(subCellTitle: NSLocalizedString("ProfileAge", comment: ""), subCellInformation: "")
        let nationalityCell = SectionData(subCellTitle: NSLocalizedString("ProfileNationality", comment: ""), subCellInformation: nationality.value ?? "")
        tableCellModel.append(TableCellModel(opened: false, cellTitle: NSLocalizedString("ProfileTitle", comment: ""), sectionData: [nameCell, surnameCell, ageCell, nationalityCell]))
        
        let mailCell = SectionData(subCellTitle: NSLocalizedString("ProfileEmail", comment: ""), subCellInformation: "")
        let phoneCell = SectionData(subCellTitle: NSLocalizedString("ProfilePhone", comment: ""), subCellInformation: "")
        let webCell = SectionData(subCellTitle: NSLocalizedString("ProfileWeb", comment: ""), subCellInformation: "")
        
        tableCellModel.append(TableCellModel(opened: false, cellTitle: NSLocalizedString("ProfileContact", comment: ""), sectionData: [mailCell, phoneCell, webCell]))
        
        guard let jobs = cvInformation?.experience else { return }
        for _ in jobs {
            jobsTable.append(SectionData(subCellTitle: "", subCellInformation: ""))
        }
        tableCellModel.append(TableCellModel(opened: false,
                                             cellTitle: NSLocalizedString("JobsTitle", comment: ""),
                                             sectionData: jobsTable))
        
        guard let skills = cvInformation?.skills else { return }
        for _ in skills {
            skillsTable.append(SectionData(subCellTitle: "", subCellInformation: ""))
        }
        tableCellModel.append(TableCellModel(opened: false,
                                             cellTitle: NSLocalizedString("SkillsTitle", comment: ""),
                                             sectionData: skillsTable))
        
        guard let institutes = cvInformation?.education else { return }
        for _ in institutes {
            schoolsTable.append(SectionData(subCellTitle: "", subCellInformation: ""))
        }
        tableCellModel.append(TableCellModel(opened: false,
                                             cellTitle: NSLocalizedString("SchoolTitle", comment: ""),
                                             sectionData: schoolsTable))
        completeDidLoad()

    }
}
