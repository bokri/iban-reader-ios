//
//  RoundedView.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import SwiftUI

/// A custom SwiftUI view that displays a rounded rectangle with optional icon and text.
struct RoundedView: View {
    /// The name of the system image to be displayed as an icon (optional).
    let iconName: String?
    
    /// The title text to be displayed.
    let title: String
    
    /// A Boolean value indicating whether the view's color scheme is inversed.
    let isInversed: Bool
    
    /// A Boolean value indicating whether the view should be displayed as small or full-width.
    let isSmall: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            // Display icon if available
            if let iconName = iconName {
                Image(systemName: iconName)
                    .font(.headline)
                    .foregroundColor(isInversed ? Color(.inversed) : Color(.primary))
            }

            // Display title text
            Text(title)
                .foregroundColor(isInversed ? Color(.inversed) : Color(.primary))
        }
        .if(isSmall == false, transform: { view in
            view.frame(maxWidth: .infinity)
        })
        .padding()
        .background(isInversed ? Color(.primary) : .clear)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.primary), lineWidth: 2)
        )
        .cornerRadius(20)
    }
}
