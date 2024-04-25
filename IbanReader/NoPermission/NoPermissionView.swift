//
//  NoPermissionView.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import SwiftUI

/// View displayed when camera permissions are not granted.
struct NoPermissionView: View {
    /// View model for handling actions and logic related to the NoPermissionView.
    @State var viewModel: NoPermissionViewModel
    
    var body: some View {
        VStack {
            // Large camera icon
            Image(systemName: "camera.fill")
                .font(.system(size: 70))
                .foregroundColor(Color(.primary))
                .padding(.bottom, 20)
            
            // Text indicating camera permissions not granted
            Text(String(localized: "camera_permissions_not_granted"))
                .foregroundColor(Color(.primary))
                .frame(alignment: .center)
                .font(.title2)
                .padding(.bottom, 30)
            
            // Button to redirect to app settings
            Button(action: {
                viewModel.openAppSettings()
            }) {
                // Styled button with gear icon and localized title
                RoundedView(iconName: "gear",
                            title: String(localized: "go_to_settings"),
                            isInversed: true,
                            isSmall: true)
            }
        }
        .padding()
    }
}

#Preview {
    NoPermissionView(viewModel: NoPermissionViewModel())
    .padding()
}
