//
//  QuizModel.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import Foundation

struct Quiz: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let category: QuizCategory
    let questions: [QuizQuestion]
    let difficulty: QuizDifficulty
    
    init(id: UUID = UUID(), title: String, description: String, category: QuizCategory, questions: [QuizQuestion], difficulty: QuizDifficulty) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.questions = questions
        self.difficulty = difficulty
    }
}

struct QuizQuestion: Identifiable, Codable {
    let id: UUID
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
    let explanation: String
    
    init(id: UUID = UUID(), question: String, options: [String], correctAnswerIndex: Int, explanation: String) {
        self.id = id
        self.question = question
        self.options = options
        self.correctAnswerIndex = correctAnswerIndex
        self.explanation = explanation
    }
}

enum QuizCategory: String, Codable, CaseIterable {
    case generalKnowledge = "General Knowledge"
    case entertainment = "Entertainment"
    case logicPuzzles = "Logic Puzzles"
    case scienceNature = "Science & Nature"
    case history = "History"
    case sports = "Sports"
    
    var icon: String {
        switch self {
        case .generalKnowledge: return "brain.head.profile"
        case .entertainment: return "film"
        case .logicPuzzles: return "puzzlepiece"
        case .scienceNature: return "leaf"
        case .history: return "book.closed"
        case .sports: return "sportscourt"
        }
    }
}

enum QuizDifficulty: String, Codable, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var color: String {
        switch self {
        case .easy: return "green"
        case .medium: return "yellow"
        case .hard: return "red"
        }
    }
}

