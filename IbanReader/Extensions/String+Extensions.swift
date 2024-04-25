//
//  String+Extensions.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation

extension String {
    /// Calculates the MOD 97 of the receiver string.
    /// - Returns: The result of the MOD 97 calculation.
    private func mod97() -> Int {
        let symbols: [Character] = Array(self)
        let swapped = symbols.dropFirst(4) + symbols.prefix(4)
        
        let mod: Int = swapped.reduce(0) { (previousMod, char) in
            let value = Int(String(char), radix: 36)! // "0" => 0, "A" => 10, "Z" => 35
            let factor = value < 10 ? 10 : 100
            return (factor * previousMod + value) % 97
        }
        
        return mod
    }
    
    /// Checks if the receiver string passes the MOD 97 check.
    /// - Returns: `true` if the receiver string passes the MOD 97 check, otherwise `false`.
    func passesMod97Check() -> Bool {
        guard self.count >= 4 else {
            return false
        }
        
        let uppercase = self.uppercased()
        
        guard uppercase.range(of: "^[0-9A-Z]*$", options: .regularExpression) != nil else {
            return false
        }
        
        return (uppercase.mod97() == 1)
    }
    
    /// Checks if the receiver string is a valid French IBAN.
    /// - Returns: `true` if the receiver string is a valid French IBAN, otherwise `false`.
    func isFrenchIBAN() -> Bool {
        // Remove spaces and convert to uppercase
        let cleanedInput = self.replacingOccurrences(of: " ", with: "").uppercased()
        
        // Check if the length is correct (27 characters for French IBAN)
        guard cleanedInput.count == 27 else {
            return false
        }
        
        // Check if it starts with "FR"
        guard cleanedInput.hasPrefix("FR") else {
            return false
        }
        
        // Check if the remaining characters pass the MOD 97 check
        return cleanedInput.passesMod97Check()
    }
    
    /// Formats the receiver string as a French IBAN.
    /// - Returns: The formatted French IBAN string, or `nil` if formatting fails.
    func formatAsFrenchIBAN() -> String? {
        // Remove all non-alphanumeric characters
        let cleanedInput = self.replacingOccurrences(of: "[^a-zA-Z0-9]", with: "", options: .regularExpression)
        
        // Ensure the cleaned input length is valid for French IBAN
        guard cleanedInput.count == 27 else {
            return nil
        }
        
        // Insert spaces every four characters
        var formattedIBAN = ""
        var index = cleanedInput.startIndex
        while index < cleanedInput.endIndex {
            let nextIndex = cleanedInput.index(index, offsetBy: 4, limitedBy: cleanedInput.endIndex) ?? cleanedInput.endIndex
            let substring = cleanedInput[index..<nextIndex]
            formattedIBAN += substring + " "
            index = nextIndex
        }
        
        // Remove trailing space
        formattedIBAN.removeLast()
        
        return formattedIBAN
    }
}
