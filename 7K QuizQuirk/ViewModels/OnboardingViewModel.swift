//
//  OnboardingViewModel.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    
    let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "Welcome to QuizQuirk",
            description: "Challenge your mind with engaging quizzes across multiple categories",
            imageName: "brain.head.profile",
            color: Color("PrimaryRed")
        ),
        OnboardingPage(
            title: "Track Your Progress",
            description: "Monitor your performance and see how you improve over time",
            imageName: "chart.line.uptrend.xyaxis",
            color: Color("AccentYellow")
        ),
        OnboardingPage(
            title: "Multiple Categories",
            description: "From entertainment to science, find quizzes that interest you",
            imageName: "list.star",
            color: Color("PrimaryRed")
        ),
        OnboardingPage(
            title: "Ready to Start?",
            description: "Let's test your knowledge and have some fun!",
            imageName: "checkmark.seal.fill",
            color: Color("AccentYellow")
        )
    ]
    
    func nextPage() {
        if currentPage < pages.count - 1 {
            withAnimation {
                currentPage += 1
            }
        }
    }
    
    func previousPage() {
        if currentPage > 0 {
            withAnimation {
                currentPage -= 1
            }
        }
    }
    
    var isLastPage: Bool {
        currentPage == pages.count - 1
    }
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    let color: Color
}

