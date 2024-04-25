//
//  IbanScannerViewModel.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import SwiftUI

/// View model for managing IBAN scanning and results.
@Observable
class IbanScannerViewModel {
    /// Indicates whether the bottom sheet should be shown.
    var shouldShowSheet: Bool = false
    
    /// Indicates whether the scanner should be active.
    var shouldScan: Bool = true
    
    /// The scanned IBAN result.
    var scanResult: String = ""
    
    /// The height of the bottom sheet.
    var sheetHeight: CGFloat = .zero
    
    /// Closure to handle the scanned IBAN result.
    var onResultFinished: (String) -> Void
    
    /// Initializes the IBanScannerViewModel with a closure to handle the scanned IBAN result.
    /// - Parameter onResultFinished: Closure to handle the scanned IBAN result.
    init(onResultFinished: @escaping (String) -> Void) {
        self.onResultFinished = onResultFinished
    }
    
    /// Checks if the scanned IBAN is valid.
    /// - Parameter input: Scanned IBAN code.
    /// - Returns: `true` if the scanned IBAN is valid, otherwise `false`.
    func isResultValid(_ input: String) -> Bool {
        let isIban = input.isFrenchIBAN()
        return isIban
    }
}
