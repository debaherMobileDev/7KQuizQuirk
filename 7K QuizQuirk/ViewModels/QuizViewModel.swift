//
//  QuizViewModel.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import Foundation
import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var quizzes: [Quiz] = []
    @Published var currentQuiz: Quiz?
    @Published var currentQuestionIndex: Int = 0
    @Published var selectedAnswerIndex: Int?
    @Published var score: Int = 0
    @Published var showExplanation: Bool = false
    @Published var isQuizComplete: Bool = false
    @Published var userAnswers: [Int] = []
    @Published var startTime: Date?
    
    private let dataService = DataService.shared
    
    init() {
        loadQuizzes()
    }
    
    func loadQuizzes() {
        quizzes = dataService.getQuizzes()
    }
    
    func startQuiz(_ quiz: Quiz) {
        currentQuiz = quiz
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        score = 0
        showExplanation = false
        isQuizComplete = false
        userAnswers = []
        startTime = Date()
    }
    
    func selectAnswer(_ index: Int) {
        guard selectedAnswerIndex == nil else { return }
        selectedAnswerIndex = index
        userAnswers.append(index)
        
        if let currentQuiz = currentQuiz {
            let currentQuestion = currentQuiz.questions[currentQuestionIndex]
            if index == currentQuestion.correctAnswerIndex {
                score += 1
            }
        }
        
        showExplanation = true
    }
    
    func nextQuestion() {
        guard let currentQuiz = currentQuiz else { return }
        
        if currentQuestionIndex < currentQuiz.questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            showExplanation = false
        } else {
            completeQuiz()
        }
    }
    
    func completeQuiz() {
        guard let quiz = currentQuiz, let startTime = startTime else { return }
        
        let timeTaken = Date().timeIntervalSince(startTime)
        let result = QuizResult(
            quizId: quiz.id,
            quizTitle: quiz.title,
            score: score,
            totalQuestions: quiz.questions.count,
            timeTaken: timeTaken,
            category: quiz.category
        )
        
        dataService.saveResult(result)
        isQuizComplete = true
    }
    
    func resetQuiz() {
        currentQuiz = nil
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        score = 0
        showExplanation = false
        isQuizComplete = false
        userAnswers = []
        startTime = nil
    }
    
    var currentQuestion: QuizQuestion? {
        guard let quiz = currentQuiz,
              currentQuestionIndex < quiz.questions.count else { return nil }
        return quiz.questions[currentQuestionIndex]
    }
    
    var progress: Double {
        guard let quiz = currentQuiz else { return 0 }
        return Double(currentQuestionIndex + 1) / Double(quiz.questions.count)
    }
}

