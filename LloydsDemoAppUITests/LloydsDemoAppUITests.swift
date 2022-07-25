//
//  LloydsDemoAppUITests.swift
//  LloydsDemoAppUITests
//
//  Created by Niraj Shah on 11/07/22.
//

import XCTest

class LloydsDemoAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        let app = XCUIApplication()
        app.launch()
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavBarTilte() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        XCTAssertTrue(app.navigationBars.staticTexts["Currency List"].exists)
    }
    
    func testTableViewCellTiltes() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        XCTAssert(app.tables.staticTexts.count > 0)
    }
    
    func testSearchBarTextAppearsInTableView() {
        let app = XCUIApplication()
        
        let searchBar = app.searchFields["Search"]
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        searchBar.typeText("Indian")
        app.buttons["Search"].tap()
        let indianRupeeCell = app.tables.staticTexts["Indian Rupee"]
        XCTAssertTrue(indianRupeeCell.exists)
    }
    
    func testSearchBarTextNotAppearsInTableView() {
        let app = XCUIApplication()
        
        let searchBar = app.searchFields["Search"]
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        searchBar.typeText("XYZ")
        app.buttons["Search"].tap()
        let cellCount = app.tables.staticTexts.count
        XCTAssertTrue(cellCount == 0)
    }
    
    
}
