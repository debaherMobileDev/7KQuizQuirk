//
//  HomeView.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = QuizViewModel()
    @State private var selectedQuiz: Quiz?
    @State private var showQuizView = false
    @State private var showResultsView = false
    @State private var showSettingsView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color("BackgroundDark"), Color("BackgroundRed"), Color("BackgroundDark")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text("QuizQuirk")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Challenge your knowledge")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        // Quick Stats
                        HStack(spacing: 12) {
                            Button(action: {
                                showResultsView = true
                            }) {
                                QuickStatCard(
                                    icon: "chart.bar.fill",
                                    title: "Results",
                                    color: Color("AccentYellow")
                                )
                            }
                            
                            Button(action: {
                                showSettingsView = true
                            }) {
                                QuickStatCard(
                                    icon: "gearshape.fill",
                                    title: "Settings",
                                    color: Color("PrimaryRed")
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Categories
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Choose a Category")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(QuizCategory.allCases, id: \.self) { category in
                                    CategoryCard(
                                        category: category,
                                        quizCount: viewModel.quizzes.filter { $0.category == category }.count
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        // Available Quizzes
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Available Quizzes")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            
                            ForEach(viewModel.quizzes) { quiz in
                                QuizCard(quiz: quiz) {
                                    selectedQuiz = quiz
                                    viewModel.startQuiz(quiz)
                                    showQuizView = true
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showQuizView) {
                if viewModel.isQuizComplete {
                    QuizCompletionView(viewModel: viewModel) {
                        showQuizView = false
                        viewModel.resetQuiz()
                    }
                } else {
                    QuizView(viewModel: viewModel)
                }
            }
            .sheet(isPresented: $showResultsView) {
                NavigationView {
                    ResultsView()
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    showResultsView = false
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                        }
                }
            }
            .sheet(isPresented: $showSettingsView) {
                NavigationView {
                    SettingsView()
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    showSettingsView = false
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                        }
                }
            }
        }
    }
}

struct QuickStatCard: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(color)
            
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .glassmorphism(cornerRadius: 16)
    }
}

struct CategoryCard: View {
    let category: QuizCategory
    let quizCount: Int
    
    private var gradientColors: [Color] {
        switch category {
        case .generalKnowledge:
            return [Color.blue, Color.purple]
        case .entertainment:
            return [Color.pink, Color.red]
        case .logicPuzzles:
            return [Color.orange, Color.yellow]
        case .scienceNature:
            return [Color.green, Color.teal]
        case .history:
            return [Color.brown, Color.orange]
        case .sports:
            return [Color.red, Color.orange]
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: gradientColors.map { $0.opacity(0.3) },
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                
                Image(systemName: category.icon)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(category.rawValue)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                Text("\(quizCount) quiz\(quizCount == 1 ? "" : "zes")")
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .glassmorphism(cornerRadius: 16)
    }
}

struct QuizCard: View {
    let quiz: Quiz
    let action: () -> Void
    
    private var difficultyColor: Color {
        switch quiz.difficulty {
        case .easy: return .green
        case .medium: return .yellow
        case .hard: return .red
        }
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: quiz.category.icon)
                        .font(.system(size: 24))
                        .foregroundColor(Color("AccentYellow"))
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 8))
                            .foregroundColor(difficultyColor)
                        
                        Text(quiz.difficulty.rawValue)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.1))
                    )
                }
                
                Text(quiz.title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(quiz.description)
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Label("\(quiz.questions.count) questions", systemImage: "questionmark.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("Start")
                            .font(.system(size: 15, weight: .semibold))
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 18))
                    }
                    .foregroundColor(Color("AccentYellow"))
                }
            }
            .padding(20)
            .glassmorphism(cornerRadius: 20)
        }
    }
}

struct QuizCompletionView: View {
    @ObservedObject var viewModel: QuizViewModel
    let onDismiss: () -> Void
    
    private var scorePercentage: Double {
        guard let quiz = viewModel.currentQuiz else { return 0 }
        return (Double(viewModel.score) / Double(quiz.questions.count)) * 100.0
    }
    
    private var grade: String {
        switch scorePercentage {
        case 90...100: return "Excellent!"
        case 75..<90: return "Great Job!"
        case 60..<75: return "Good Work!"
        case 40..<60: return "Keep Trying!"
        default: return "Practice More!"
        }
    }
    
    private var gradeColor: Color {
        switch scorePercentage {
        case 90...100: return .green
        case 75..<90: return .blue
        case 60..<75: return .yellow
        default: return .red
        }
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color("BackgroundDark"), Color("BackgroundRed"), Color("BackgroundDark")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Celebration icon
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [gradeColor.opacity(0.3), gradeColor.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 180, height: 180)
                        .blur(radius: 30)
                    
                    Image(systemName: scorePercentage >= 75 ? "star.fill" : "checkmark.circle.fill")
                        .font(.system(size: 90))
                        .foregroundColor(gradeColor)
                }
                
                // Results
                VStack(spacing: 12) {
                    Text(grade)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("You scored")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Text("\(viewModel.score)/\(viewModel.currentQuiz?.questions.count ?? 0)")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(Color("AccentYellow"))
                    
                    Text(String(format: "%.0f%%", scorePercentage))
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                // Actions
                VStack(spacing: 16) {
                    Button(action: {
                        if let quiz = viewModel.currentQuiz {
                            viewModel.resetQuiz()
                            viewModel.startQuiz(quiz)
                        }
                    }) {
                        Text("Try Again")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("BackgroundDark"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color("AccentYellow"), Color("AccentYellow").opacity(0.8)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                            )
                    }
                    
                    Button(action: onDismiss) {
                        Text("Back to Home")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white.opacity(0.15))
                            )
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    HomeView()
}

