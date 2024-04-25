//
//  IbanReaderUITests.swift
//  IbanReaderUITests
//
//  Created by Aymen Bokri on 25/04/2024.
//

import XCTest

final class IbanReaderUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testIBANScanningAndInput() throws {
        // Step 1: Launch App
        XCTAssertTrue(app.isDisplayingTabBar)

        // Step 2: Navigate to IBAN Scanning Screen
        let wireTab = app.tabBars.buttons["Virements"]
        wireTab.tap()
        XCTAssertTrue(app.isDisplayingIBANScanningScreen)

        // Step 3: Enter IBAN Manually
        let ibanTextField = app.textFields["FR76 XXXX"]
        ibanTextField.tap()
        ibanTextField.typeText("FR7630006000011234567890189") // Enter a valid IBAN
        XCTAssertTrue(ibanTextField.value as! String == "FR76 3000 6000 0112 3456 7890 189") // Verify formatting
        
    }
}

// Extensions for UI Test Helpers
extension XCUIApplication {
    var isDisplayingTabBar: Bool {
        return tabBars.count > 0
    }

    var isDisplayingIBANScanningScreen: Bool {
        return staticTexts["Scanner"].exists
    }
}

