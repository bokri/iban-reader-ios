//
//  ContentView.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import SwiftUI
import VisionKit

struct ContentView: View {

    // MARK: - Properties

    /// State variable to store the entered IBAN.
    @State var iban: String = ""

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                // Title for IBAN scanning section.
                Text("scan_import_iban_title")
                    .foregroundStyle(.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Navigation link to IBAN scanner view if supported.
                if DataScannerViewController.isSupported {
                    NavigationLink {
                        IBanScannerView(viewModel: IbanScannerViewModel(onResultFinished: onResultFinished(_:)))
                    } label: {
                        // Button to trigger IBAN scanning.
                        RoundedView(iconName: "camera.fill",
                                    title: String(localized: "scan_cta"),
                                    isInversed: false,
                                    isSmall: true)
                    }.padding()
                }
                
                // Text field for manual IBAN entry.
                IbanTextField(placeHolder: String(localized: "iban_placeholder"), errorMessage: String(localized: "iban_error"), value: $iban) { input in
                    input.isFrenchIBAN()
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.background))
            .navigationTitle("add_beneficiary")
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(Color(.primary))
        .onChange(of: iban) { _, newValue in
            // Automatically format the IBAN as French IBAN if valid.
            if newValue.isFrenchIBAN() {
                iban = newValue.formatAsFrenchIBAN() ?? newValue
            }
        }
    }
    
    // MARK: - Functions
    
    /**
     Callback function invoked when the IBAN scanning result is finished.
     
     - Parameter iban: The scanned IBAN result.
     */
    func onResultFinished(_ iban: String) {
        self.iban = iban
    }
}

#Preview {
    ContentView()
}
