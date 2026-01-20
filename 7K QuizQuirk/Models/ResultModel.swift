//
//  ResultModel.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import Foundation

struct QuizResult: Identifiable, Codable {
    let id: UUID
    let quizId: UUID
    let quizTitle: String
    let score: Int
    let totalQuestions: Int
    let date: Date
    let timeTaken: TimeInterval
    let category: QuizCategory
    
    var percentage: Double {
        return (Double(score) / Double(totalQuestions)) * 100.0
    }
    
    var grade: String {
        switch percentage {
        case 90...100: return "Excellent!"
        case 75..<90: return "Great!"
        case 60..<75: return "Good"
        case 40..<60: return "Fair"
        default: return "Keep Trying!"
        }
    }
    
    init(id: UUID = UUID(), quizId: UUID, quizTitle: String, score: Int, totalQuestions: Int, date: Date = Date(), timeTaken: TimeInterval, category: QuizCategory) {
        self.id = id
        self.quizId = quizId
        self.quizTitle = quizTitle
        self.score = score
        self.totalQuestions = totalQuestions
        self.date = date
        self.timeTaken = timeTaken
        self.category = category
    }
}

struct UserStats: Codable {
    var totalQuizzesTaken: Int
    var totalQuestionsAnswered: Int
    var totalCorrectAnswers: Int
    var averageScore: Double
    var favoriteCategory: QuizCategory?
    
    var accuracy: Double {
        guard totalQuestionsAnswered > 0 else { return 0 }
        return (Double(totalCorrectAnswers) / Double(totalQuestionsAnswered)) * 100.0
    }
    
    init(totalQuizzesTaken: Int = 0, totalQuestionsAnswered: Int = 0, totalCorrectAnswers: Int = 0, averageScore: Double = 0, favoriteCategory: QuizCategory? = nil) {
        self.totalQuizzesTaken = totalQuizzesTaken
        self.totalQuestionsAnswered = totalQuestionsAnswered
        self.totalCorrectAnswers = totalCorrectAnswers
        self.averageScore = averageScore
        self.favoriteCategory = favoriteCategory
    }
}

