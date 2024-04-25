//
//  ScannerView.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import SwiftUI

/// A SwiftUI representation of a scanner view.
@MainActor
struct ScannerView: UIViewControllerRepresentable {
    
    /// Binding for the scanned result.
    @Binding var scanResult: String
    
    /// Binding to control whether scanning should continue.
    @Binding var shouldScan: Bool
    
    /// Closure to check if the scanned result is valid.
    var isResultValid: (String) -> Bool
    
    /// Creates the scanner view controller.
    /// - Parameter context: The context in which the view controller will be created.
    /// - Returns: The scanner view controller.
    func makeUIViewController(context: Context) -> ScannerViewController {
        let scannerVC = ScannerViewController(viewModel: ScannerViewModel())
        scannerVC.setupDelegate(delegate: context.coordinator)
        return scannerVC
    }
    
    /// Updates the scanner view controller.
    /// - Parameters:
    ///   - viewController: The scanner view controller to update.
    ///   - context: The context in which the update is made.
    func updateUIViewController(_ viewController: ScannerViewController, context: Context) {
        if shouldScan {
            viewController.startScanning()
        } else {
            viewController.stopScanning()
        }
    }
    
    /// Creates a coordinator for the scanner view.
    /// - Returns: The coordinator.
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    /// A coordinator class for the scanner view.
    @MainActor
    class Coordinator: NSObject, ScannerViewProtocol {
        var parent: ScannerView
        
        /// Initializes the coordinator with the parent scanner view.
        /// - Parameter parent: The parent scanner view.
        init(_ parent: ScannerView) {
            self.parent = parent
        }
        
        /// Handles the scanner result.
        /// - Parameter result: The scanned result.
        func onScannerResult(result: String) {
            if parent.isResultValid(result) {
                parent.scanResult = result
                parent.shouldScan = false
            }
        }
    }
}
