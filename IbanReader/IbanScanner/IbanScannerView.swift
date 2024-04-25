//
//  IbanScannerView.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import SwiftUI
import VisionKit

/// View for scanning and recognizing IBAN codes using VisionKit.
struct IBanScannerView: View {
    
    /// View model for IBAN scanning.
    @State var viewModel: IbanScannerViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    /// Initializes the IBanScannerView.
    /// - Parameters:
    ///   - viewModel: View model for IBAN scanning.
    ///   - onResultFinished: Closure to handle the scanned IBAN result.
    init(
        viewModel: IbanScannerViewModel
    ) {
        self._viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack {
            // Check if IBAN scanning is available
            if DataScannerViewController.isAvailable {
                // Display the scanner view if scanning is available
                ScannerView(
                    scanResult: $viewModel.scanResult,
                    shouldScan: $viewModel.shouldScan,
                    isResultValid: viewModel.isResultValid(_:)
                )
                .ignoresSafeArea()
                .sheet(isPresented: $viewModel.shouldShowSheet) {
                    // Present the bottom sheet with scanned IBAN information
                    IbanBottomSheet(iban: viewModel.scanResult) {
                        viewModel.onResultFinished(viewModel.scanResult)
                        viewModel.shouldShowSheet = false
                        presentationMode.wrappedValue.dismiss()
                    } negativeAction: {
                        viewModel.shouldScan = true
                        viewModel.shouldShowSheet = false
                        viewModel.scanResult = ""
                    }
                    .presentationDetents(
                        [.medium, .large],
                        selection: .constant(PresentationDetent.medium)
                    )
                }
            } else {
                // Display a view indicating that scanning is not available
                NoPermissionView(viewModel: NoPermissionViewModel())
            }
        }
        .onChange(of: viewModel.scanResult) { _, newValue in
            // Show the bottom sheet when a new result is available
            if !newValue.isEmpty {
                viewModel.shouldShowSheet = true
            }
        }
        .onChange(of: viewModel.shouldShowSheet) { _, newValue in
            // Reset the scanning state when the sheet is dismissed
            if !newValue {
                viewModel.shouldScan = true
                viewModel.scanResult = ""
            }
        }
        .navigationTitle(String(localized: "scan_your_iban"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}
