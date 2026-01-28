//
//  ResultsView.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import SwiftUI

struct ResultsView: View {
    private let dataService = DataService.shared
    @State private var results: [QuizResult] = []
    @State private var stats: UserStats = UserStats()
    @State private var selectedFilter: QuizCategory? = nil
    
    var filteredResults: [QuizResult] {
        if let filter = selectedFilter {
            return results.filter { $0.category == filter }
        }
        return results
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.backgroundDark, Color.backgroundRed, Color.backgroundDark],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Stats Overview
                    VStack(spacing: 16) {
                        Text("Your Statistics")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 12) {
                            StatCard(
                                title: "Quizzes",
                                value: "\(stats.totalQuizzesTaken)",
                                icon: "list.clipboard.fill",
                                color: Color("AccentYellow")
                            )
                            
                            StatCard(
                                title: "Accuracy",
                                value: String(format: "%.1f%%", stats.accuracy),
                                icon: "target",
                                color: Color("PrimaryRed")
                            )
                        }
                        
                        HStack(spacing: 12) {
                            StatCard(
                                title: "Avg Score",
                                value: String(format: "%.1f%%", stats.averageScore),
                                icon: "chart.line.uptrend.xyaxis",
                                color: Color.green
                            )
                            
                            StatCard(
                                title: "Questions",
                                value: "\(stats.totalQuestionsAnswered)",
                                icon: "questionmark.circle.fill",
                                color: Color.blue
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Category filter
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            FilterChip(
                                title: "All",
                                isSelected: selectedFilter == nil
                            ) {
                                selectedFilter = nil
                            }
                            
                            ForEach(QuizCategory.allCases, id: \.self) { category in
                                FilterChip(
                                    title: category.rawValue,
                                    isSelected: selectedFilter == category
                                ) {
                                    selectedFilter = category
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Results history
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Results")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                        
                        if filteredResults.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "tray.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.white.opacity(0.3))
                                
                                Text("No results yet")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white.opacity(0.6))
                                
                                Text("Complete some quizzes to see your results here!")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white.opacity(0.4))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 60)
                        } else {
                            ForEach(filteredResults) { result in
                                ResultCard(result: result)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        results = dataService.getResults()
        stats = dataService.getStats()
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                Spacer()
            }
            
            Text(value)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
            
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white.opacity(0.6))
                .textCase(.uppercase)
                .tracking(0.5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .glassmorphism(cornerRadius: 16)
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(isSelected ? .backgroundDark : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color("AccentYellow") : Color.white.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.clear : Color.white.opacity(0.2), lineWidth: 1)
                )
        }
        .animation(.spring(), value: isSelected)
    }
}

struct ResultCard: View {
    let result: QuizResult
    
    private var scoreColor: Color {
        switch result.percentage {
        case 90...100: return .green
        case 75..<90: return .blue
        case 60..<75: return .yellow
        default: return .red
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(result.quizTitle)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(result.category.rawValue)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(String(format: "%.0f%%", result.percentage))
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(scoreColor)
                    
                    Text(result.grade)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            
            Divider()
                .background(Color.white.opacity(0.2))
            
            HStack(spacing: 20) {
                Label("\(result.score)/\(result.totalQuestions)", systemImage: "checkmark.circle.fill")
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.7))
                
                Label(formatTime(result.timeTaken), systemImage: "clock.fill")
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.7))
                
                Spacer()
                
                Text(formatDate(result.date))
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.5))
            }
        }
        .padding(16)
        .glassmorphism(cornerRadius: 16)
    }
    
    private func formatTime(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationView {
        ResultsView()
    }
}

