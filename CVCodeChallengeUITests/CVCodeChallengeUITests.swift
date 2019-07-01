//
//  CVCodeChallengeUITests.swift
//  CVCodeChallengeUITests
//
//  Created by Ricardo Isidro Ramirez on 7/1/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import XCTest

class CVCodeChallengeUITests: XCTestCase {
    
    var app: XCUIApplication!
    let tablesQuery = XCUIApplication().tables
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testProfileDetails() {
        let myProfileStaticText = tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["My Profile"]/*[[".cells.staticTexts[\"My Profile\"]",".staticTexts[\"My Profile\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        myProfileStaticText.tap()
        let name = tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Ricardo Isidro Ramírez"]/*[[".cells.staticTexts[\"Ricardo Isidro Ramírez\"]",".staticTexts[\"Ricardo Isidro Ramírez\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        let age = tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["32"]/*[[".cells.staticTexts[\"32\"]",".staticTexts[\"32\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        let country = tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Mexican"]/*[[".cells.staticTexts[\"Mexican\"]",".staticTexts[\"Mexican\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        if myProfileStaticText.isSelected {
            XCTAssertTrue(name.exists)
            XCTAssertTrue(age.exists)
            XCTAssertTrue(country.exists)
        }
        myProfileStaticText.tap()
    }
    
    func testJobDetails() {
        let myJobStaticText = tablesQuery.cells.staticTexts["Former Jobs"]
        myJobStaticText.tap()
        let position = tablesQuery.cells.staticTexts["iOS Developer"]
        if myJobStaticText.isSelected {
            XCTAssertTrue(position.exists)
        }
        myJobStaticText.tap()
    }
    
    func testSkillDetails() {
        let mySkillsStaticText = tablesQuery.cells.staticTexts["Skills"]
        mySkillsStaticText.tap()
        let skill1 = tablesQuery.cells.staticTexts["Swift"]
        let skill2 = tablesQuery.cells.staticTexts["AutoLayout"]
        let skill3 = tablesQuery.cells.staticTexts["Networking"]
        if mySkillsStaticText.isSelected {
            XCTAssertTrue(skill1.exists)
            XCTAssertTrue(skill2.exists)
            XCTAssertTrue(skill3.exists)
        }
    }
}

