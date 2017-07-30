//
//  calculatorUITests.swift
//  calculatorUITests
//
//  Created by Rob Gilbert on 6/26/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import XCTest

class calculatorUITests: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDoesAppLoad() {
        XCTAssertTrue(app.otherElements["MainCalculator"].exists)
    }
    
    func testSimpleCalculation() {
        XCUIDevice.shared().orientation = .landscapeRight
        
        let app = XCUIApplication()
        app.buttons["8"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        XCTAssertTrue(app.otherElements["bottomLabel"].value as! String == "13")
        app.buttons["C"].tap()
        
    }
    
}
