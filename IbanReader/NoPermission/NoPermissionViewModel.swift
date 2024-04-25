//
//  NoPermissionViewModel.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import SwiftUI

/// View model for handling actions and logic related to the NoPermissionView.
@Observable
class NoPermissionViewModel {
    /// Opens the app's settings.
    func openAppSettings() {
        Logger.debug("Redirecting user to settings")
        
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        UIApplication.shared.open(settingsUrl)
    }
}
