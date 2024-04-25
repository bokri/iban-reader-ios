//
//  DataScannerViewController+Extensions.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import VisionKit

extension DataScannerViewController {
    
    /// Creates a `DataScannerViewController` instance with customized settings.
    /// - Returns: A `DataScannerViewController` instance.
    static func factory() -> DataScannerViewController {
        let scanner = DataScannerViewController(
            recognizedDataTypes: [
                .text()
            ],
            isGuidanceEnabled: false,
            isHighlightingEnabled: false
        )
        
        return scanner
    }
}
