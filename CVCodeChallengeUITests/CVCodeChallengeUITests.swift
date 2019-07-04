import XCTest

class CVCodeChallengeUITests: XCTestCase {
    
    var app = XCUIApplication()
    let tablesQuery = XCUIApplication().tables
    let imageQuery = XCUIApplication().images
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testSectionProfileCellsExists() {
        let myProfileCell = tablesQuery.cells["cell_section_profile_id"]
        XCTAssertTrue(myProfileCell.exists)
        myProfileCell.tap()
        XCTAssertTrue(app.tables.cells["cell_detail_id"].exists)
    }
    
    func testSectionContactInfoCellsExists() {
        let myContactCell = tablesQuery.cells["cell_section_contact_id"]
        XCTAssertTrue(myContactCell.exists)
        myContactCell.tap()
        XCTAssertTrue(app.tables.cells["cell_contact_info_id"].exists)
    }
    
    func testSectionExperienceCellsExists() {
        let myExperienceCell = tablesQuery.cells["cell_section_experience_id"]
        XCTAssertTrue(myExperienceCell.exists)
        myExperienceCell.tap()
        XCTAssertTrue(app.tables.cells["cell_experience_id"].exists)
    }
    
    func testSectionSkillsCellsExists() {
        let mySkillsCell = tablesQuery.cells["cell_section_skills_id"]
        XCTAssertTrue(mySkillsCell.exists)
        mySkillsCell.tap()
        XCTAssertTrue(app.tables.cells["cell_skills_id"].exists)
    }
    
    func testSectionEducationCellsExists() {
        let myEducationCell = tablesQuery.cells["cell_section_education_id"]
        XCTAssertTrue(myEducationCell.exists)
        myEducationCell.tap()
        XCTAssertTrue(app.tables.cells["cell_education_id"].exists)
    }
}

