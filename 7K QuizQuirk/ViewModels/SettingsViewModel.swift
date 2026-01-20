//
//  SettingsViewModel.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
    @AppStorage("vibrationEnabled") var vibrationEnabled: Bool = true
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    
    private let dataService = DataService.shared
    
    func deleteAccount() {
        // Clear all user data
        dataService.deleteAllResults()
        
        // Reset all settings to defaults
        soundEnabled = true
        vibrationEnabled = true
        darkModeEnabled = true
        
        // Reset onboarding
        UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
    }
    
    func getAppVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "1.0"
    }
    
    func getBuildNumber() -> String {
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return build
        }
        return "1"
    }
}

