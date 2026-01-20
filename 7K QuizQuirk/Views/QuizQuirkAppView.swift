//
//  QuizQuirkAppView.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import SwiftUI

struct QuizQuirkAppView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    var body: some View {
        Group {
            if hasCompletedOnboarding {
                HomeView()
            } else {
                OnboardingView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    QuizQuirkAppView()
}

