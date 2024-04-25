//
//  IbanReaderTests.swift
//  IbanReaderTests
//
//  Created by Aymen Bokri on 25/04/2024.
//

import XCTest
@testable import IbanReader

class StringExtensionsTests: XCTestCase {
    
    func testPassesMod97Check_ValidIBAN_ReturnsTrue() {
        // Arrange
        let validIBAN = "FR7630001007941234567890185"
        
        // Act
        let result = validIBAN.passesMod97Check()
        
        // Assert
        XCTAssertTrue(result)
    }
    
    func testPassesMod97Check_InvalidIBAN_ReturnsFalse() {
        // Arrange
        let invalidIBAN = "FR7630001007941234567890186"
        
        // Act
        let result = invalidIBAN.passesMod97Check()
        
        // Assert
        XCTAssertFalse(result)
    }
    
    func testIsFrenchIBAN_ValidIBAN_ReturnsTrue() {
        // Arrange
        let validIBAN = "FR7630001007941234567890185"
        
        // Act
        let result = validIBAN.isFrenchIBAN()
        
        // Assert
        XCTAssertTrue(result)
    }
    
    func testIsFrenchIBAN_InvalidIBAN_ReturnsFalse() {
        // Arrange
        let invalidIBAN = "FR7630001007941234567890186"
        
        // Act
        let result = invalidIBAN.isFrenchIBAN()
        
        // Assert
        XCTAssertFalse(result)
    }
    
    func testFormatAsFrenchIBAN_ValidInput_ReturnsFormattedIBAN() {
        // Arrange
        let input = "FR7630001007941234567890185"
        
        // Act
        let formattedIBAN = input.formatAsFrenchIBAN()
        
        // Assert
        XCTAssertEqual(formattedIBAN, "FR76 3000 1007 9412 3456 7890 185")
    }
    
    func testFormatAsFrenchIBAN_InvalidInput_ReturnsNil() {
        // Arrange
        let input = "FR763000100794123456789018" // Invalid length
        
        // Act
        let formattedIBAN = input.formatAsFrenchIBAN()
        
        // Assert
        XCTAssertNil(formattedIBAN)
    }
}

