//
//  ScannerViewProtocol.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation

/// Protocol for handling scanner results asynchronously.
protocol ScannerViewProtocol: AnyObject {
    
    /// Handles scanner result asynchronously.
    /// - Parameter result: The scanned result.
    func onScannerResult(result: String) async
}
