import XCTest
@testable import CVCodeChallenge

class CVCodeChallengeViewModelTests: XCTestCase {
    var dummyCVInformation: CVInformation.CodingData?
    var mockCVViewModel: TableViewModelController?
    
    override func setUp() {
        super.setUp()
        
        guard let url = Bundle.main.url(forResource: "CVInfo", withExtension: "json") else {
            XCTFail()
            return
        }
        
        guard let data = try? Data(contentsOf: url, options: .alwaysMapped) else {
            XCTFail()
            return
        }
        
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.CodingData.self, from: data) else {
            XCTFail()
            return
        }
        
        mockCVViewModel = TableViewModelController()
        
        dummyCVInformation = infoCV
        mockCVViewModel?.cvInformation = infoCV
    }
    
    
    func testProfileDidLoad() {
        XCTAssertEqual(mockCVViewModel?.cvInformation?.info.name, dummyCVInformation?.info.name)
        XCTAssertEqual(mockCVViewModel?.cvInformation?.info.surnames, dummyCVInformation?.info.surnames)
        XCTAssertEqual(mockCVViewModel?.cvInformation?.info.age, dummyCVInformation?.info.age)
        XCTAssertEqual(mockCVViewModel?.cvInformation?.info.nationality, dummyCVInformation?.info.nationality)
    }
    
    func testContactDidLoad() {
        XCTAssertEqual(mockCVViewModel?.cvInformation?.contact.mail, dummyCVInformation?.contact.mail)
        XCTAssertEqual(mockCVViewModel?.cvInformation?.contact.phone, dummyCVInformation?.contact.phone)
        XCTAssertEqual(mockCVViewModel?.cvInformation?.contact.webpage, dummyCVInformation?.contact.webpage)
    }
    
    func testEducationDidLoad() {
        guard let mock = mockCVViewModel?.cvInformation?.education else {
            XCTFail()
            return
        }
        for (index, education) in mock.enumerated() {
            XCTAssertEqual(education.school, dummyCVInformation?.education[index].school)
            XCTAssertEqual(education.degree, dummyCVInformation?.education[index].degree)
            XCTAssertEqual(education.period, dummyCVInformation?.education[index].period)
        }
    }
    
    func testExperienceDidLoad() {
        guard let mock = mockCVViewModel?.cvInformation?.experience else {
            XCTFail()
            return
        }
        for (index, experience) in mock.enumerated() {
            XCTAssertEqual(experience.job, dummyCVInformation?.experience[index].job)
            XCTAssertEqual(experience.start, dummyCVInformation?.experience[index].start)
            XCTAssertEqual(experience.end, dummyCVInformation?.experience[index].end)
            XCTAssertEqual(experience.place, dummyCVInformation?.experience[index].place)
            XCTAssertEqual(experience.description, dummyCVInformation?.experience[index].description)
        }
    }

    func testSkillDidLoad() {
        guard let mock = mockCVViewModel?.cvInformation?.skills else {
            XCTFail()
            return
        }
        for (index, skill) in mock.enumerated() {
            XCTAssertEqual(skill.skill, dummyCVInformation?.skills[index].skill)
            XCTAssertEqual(skill.level, dummyCVInformation?.skills[index].level)
        }
    }
    
    override func tearDown() {
        dummyCVInformation = nil
        mockCVViewModel = nil
        super.tearDown()
    }
}
