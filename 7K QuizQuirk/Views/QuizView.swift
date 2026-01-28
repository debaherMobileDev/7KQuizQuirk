//
//  QuizView.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.backgroundDark, Color.backgroundRed, Color.backgroundDark],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header with progress
                VStack(spacing: 16) {
                    HStack {
                        Button(action: {
                            viewModel.resetQuiz()
                            dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        Text("\(viewModel.currentQuestionIndex + 1) / \(viewModel.currentQuiz?.questions.count ?? 0)")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("Score: \(viewModel.score)")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.accentYellow)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Progress bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.1))
                                .frame(height: 8)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    LinearGradient(
                                        colors: [Color("AccentYellow"), Color("PrimaryRed")],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: geometry.size.width * viewModel.progress, height: 8)
                                .animation(.spring(), value: viewModel.progress)
                        }
                    }
                    .frame(height: 8)
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
                
                // Question content
                ScrollView {
                    if let question = viewModel.currentQuestion {
                        VStack(spacing: 24) {
                            // Question card
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Question")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.accentYellow)
                                    .textCase(.uppercase)
                                    .tracking(1)
                                
                                Text(question.question)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                    .lineSpacing(4)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(24)
                            .glassmorphism(cornerRadius: 20)
                            .padding(.horizontal, 20)
                            
                            // Answer options
                            VStack(spacing: 12) {
                                ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                                    AnswerButton(
                                        text: option,
                                        index: index,
                                        isSelected: viewModel.selectedAnswerIndex == index,
                                        isCorrect: index == question.correctAnswerIndex,
                                        showResult: viewModel.showExplanation
                                    ) {
                                        viewModel.selectAnswer(index)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            // Explanation
                            if viewModel.showExplanation {
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Image(systemName: viewModel.selectedAnswerIndex == question.correctAnswerIndex ? "checkmark.circle.fill" : "xmark.circle.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(viewModel.selectedAnswerIndex == question.correctAnswerIndex ? .green : .red)
                                        
                                        Text(viewModel.selectedAnswerIndex == question.correctAnswerIndex ? "Correct!" : "Incorrect")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    
                                    Text(question.explanation)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white.opacity(0.9))
                                        .lineSpacing(4)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.1))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(viewModel.selectedAnswerIndex == question.correctAnswerIndex ? Color.green.opacity(0.5) : Color.red.opacity(0.5), lineWidth: 2)
                                        )
                                )
                                .padding(.horizontal, 20)
                                .transition(.opacity.combined(with: .scale))
                                
                                // Next button
                                Button(action: {
                                    viewModel.nextQuestion()
                                }) {
                                    Text(viewModel.currentQuestionIndex < (viewModel.currentQuiz?.questions.count ?? 1) - 1 ? "Next Question" : "Finish Quiz")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.backgroundDark)
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
                                .padding(.horizontal, 20)
                                .padding(.top, 8)
                            }
                        }
                        .padding(.vertical, 20)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct AnswerButton: View {
    let text: String
    let index: Int
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void
    
    private var backgroundColor: Color {
        if showResult {
            if isCorrect {
                return Color.green.opacity(0.3)
            } else if isSelected {
                return Color.red.opacity(0.3)
            }
        } else if isSelected {
            return Color("AccentYellow").opacity(0.2)
        }
        return Color.white.opacity(0.08)
    }
    
    private var borderColor: Color {
        if showResult {
            if isCorrect {
                return Color.green
            } else if isSelected {
                return Color.red
            }
        } else if isSelected {
            return Color("AccentYellow")
        }
        return Color.white.opacity(0.15)
    }
    
    var body: some View {
        Button(action: {
            if !showResult {
                action()
            }
        }) {
            HStack {
                Text(text)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                if showResult && (isCorrect || isSelected) {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(isCorrect ? .green : .red)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderColor, lineWidth: 2)
                    )
            )
        }
        .disabled(showResult)
        .animation(.spring(), value: isSelected)
        .animation(.spring(), value: showResult)
    }
}

#Preview {
    let viewModel = QuizViewModel()
    viewModel.startQuiz(DataService.shared.getQuizzes()[0])
    return QuizView(viewModel: viewModel)
}

