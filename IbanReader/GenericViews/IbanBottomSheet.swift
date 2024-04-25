//
//  IbanBottomSheet.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import SwiftUI

/// A view representing a bottom sheet for displaying scanned IBAN information.
struct IbanBottomSheet: View {
    /// The scanned IBAN string.
    var iban: String
    
    /// Closure to be executed when the positive action button is tapped.
    var positiveAction: () -> Void
    
    /// Closure to be executed when the negative action button is tapped.
    var negativeAction: () -> Void
    
    /// The body of the bottom sheet view.
    var body: some View {
        VStack(alignment: .center) {
            Text("scanned_iban_title")
                .foregroundStyle(.text)
                .fontWeight(.bold)
                .padding()
            
            Text("scanned_iban_subtitle")
                .foregroundStyle(.text)
            
            Text(iban)
                .foregroundStyle(.text)
                .fontWeight(.bold)
            
            Button(action: positiveAction) {
                RoundedView(iconName: nil,
                            title: String(localized: "validate_cta"),
                            isInversed: true,
                            isSmall: false)
                    .padding()
            }
            
            Button(action: negativeAction) {
                RoundedView(iconName: nil,
                            title: String(localized: "restart_cta"),
                            isInversed: false,
                            isSmall: false)
                    .padding()
            }
        }
    }
}
