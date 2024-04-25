//
//  IbanReaderApp.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import SwiftUI

@main
struct IbanReaderApp: App {
    // MARK: - Initialization
    
    init() {
        // Configure appearance of the navigation bar.
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            // Main navigation view containing the tab view.
            NavigationView {
                // Tab view with different sections of the app.
                TabView {
                    // Placeholder text for the "Accounts" tab.
                    Text("accounts")
                        .tabItem {
                            Label("accounts", systemImage: "wallet.pass")
                        }
                    
                    // Main content view for scanning IBANs.
                    ContentView()
                        .tabItem {
                            Label("wire", systemImage: "arrow.left.arrow.right")
                        }
                    
                    // Placeholder text for the "Help" tab.
                    Text("help")
                        .tabItem {
                            Label("help", systemImage: "bubble.left.and.bubble.right")
                        }
                    
                    // Placeholder text for the "More" tab.
                    Text("more")
                        .tabItem {
                            Label("more", systemImage: "ellipsis")
                        }
                }
                // Set accent color for tab view.
                .accentColor(Color(.primary))
            }
        }
    }
}
