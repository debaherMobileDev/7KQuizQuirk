//
//  DataService.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import Foundation

class DataService {
    static let shared = DataService()
    
    private let resultsKey = "quizResults"
    private let statsKey = "userStats"
    
    private init() {}
    
    // MARK: - Quiz Data
    func getQuizzes() -> [Quiz] {
        return [
            // General Knowledge Quizzes
            Quiz(
                title: "World Capitals",
                description: "Test your knowledge of world capitals",
                category: .generalKnowledge,
                questions: [
                    QuizQuestion(
                        question: "What is the capital of France?",
                        options: ["London", "Berlin", "Paris", "Madrid"],
                        correctAnswerIndex: 2,
                        explanation: "Paris is the capital and most populous city of France."
                    ),
                    QuizQuestion(
                        question: "What is the capital of Japan?",
                        options: ["Seoul", "Tokyo", "Beijing", "Bangkok"],
                        correctAnswerIndex: 1,
                        explanation: "Tokyo is the capital of Japan and the most populous metropolitan area in the world."
                    ),
                    QuizQuestion(
                        question: "What is the capital of Australia?",
                        options: ["Sydney", "Melbourne", "Canberra", "Perth"],
                        correctAnswerIndex: 2,
                        explanation: "Canberra is the capital city of Australia, not Sydney as commonly thought."
                    ),
                    QuizQuestion(
                        question: "What is the capital of Brazil?",
                        options: ["Rio de Janeiro", "São Paulo", "Brasília", "Salvador"],
                        correctAnswerIndex: 2,
                        explanation: "Brasília has been the capital of Brazil since 1960."
                    ),
                    QuizQuestion(
                        question: "What is the capital of Canada?",
                        options: ["Toronto", "Vancouver", "Ottawa", "Montreal"],
                        correctAnswerIndex: 2,
                        explanation: "Ottawa is the capital city of Canada, located in Ontario."
                    )
                ],
                difficulty: .easy
            ),
            
            // Entertainment Quizzes
            Quiz(
                title: "Movie Classics",
                description: "How well do you know classic movies?",
                category: .entertainment,
                questions: [
                    QuizQuestion(
                        question: "Who directed 'The Godfather'?",
                        options: ["Martin Scorsese", "Francis Ford Coppola", "Steven Spielberg", "Quentin Tarantino"],
                        correctAnswerIndex: 1,
                        explanation: "Francis Ford Coppola directed The Godfather (1972), one of the greatest films ever made."
                    ),
                    QuizQuestion(
                        question: "What year was the first Star Wars movie released?",
                        options: ["1975", "1977", "1979", "1980"],
                        correctAnswerIndex: 1,
                        explanation: "Star Wars: A New Hope was released in 1977 and revolutionized cinema."
                    ),
                    QuizQuestion(
                        question: "Which movie won the first Academy Award for Best Picture?",
                        options: ["Wings", "The Jazz Singer", "Sunrise", "7th Heaven"],
                        correctAnswerIndex: 0,
                        explanation: "Wings (1927) won the first Academy Award for Best Picture at the 1st Academy Awards."
                    ),
                    QuizQuestion(
                        question: "Who played Jack Dawson in Titanic?",
                        options: ["Brad Pitt", "Leonardo DiCaprio", "Tom Cruise", "Johnny Depp"],
                        correctAnswerIndex: 1,
                        explanation: "Leonardo DiCaprio played Jack Dawson opposite Kate Winslet in Titanic (1997)."
                    ),
                    QuizQuestion(
                        question: "What is the highest-grossing film of all time (not adjusted for inflation)?",
                        options: ["Avatar", "Avengers: Endgame", "Titanic", "Star Wars: The Force Awakens"],
                        correctAnswerIndex: 0,
                        explanation: "Avatar (2009) is the highest-grossing film of all time with over $2.9 billion worldwide."
                    )
                ],
                difficulty: .medium
            ),
            
            // Logic Puzzles
            Quiz(
                title: "Brain Teasers",
                description: "Challenge your logical thinking",
                category: .logicPuzzles,
                questions: [
                    QuizQuestion(
                        question: "If you have 3 apples and you take away 2, how many do you have?",
                        options: ["1", "2", "3", "5"],
                        correctAnswerIndex: 1,
                        explanation: "You have 2 apples because you took 2 away, meaning you now possess them."
                    ),
                    QuizQuestion(
                        question: "What comes next in the sequence: 2, 4, 8, 16, __?",
                        options: ["24", "32", "20", "18"],
                        correctAnswerIndex: 1,
                        explanation: "Each number is doubled: 2×2=4, 4×2=8, 8×2=16, 16×2=32."
                    ),
                    QuizQuestion(
                        question: "A farmer has 17 sheep, and all but 9 die. How many are left?",
                        options: ["8", "9", "17", "0"],
                        correctAnswerIndex: 1,
                        explanation: "'All but 9' means all except 9, so 9 sheep are left alive."
                    ),
                    QuizQuestion(
                        question: "Which number should replace the question mark: 1, 1, 2, 3, 5, 8, ?",
                        options: ["11", "13", "15", "10"],
                        correctAnswerIndex: 1,
                        explanation: "This is the Fibonacci sequence where each number is the sum of the previous two: 5+8=13."
                    ),
                    QuizQuestion(
                        question: "If 5 cats can catch 5 mice in 5 minutes, how many cats are needed to catch 100 mice in 100 minutes?",
                        options: ["5", "20", "100", "10"],
                        correctAnswerIndex: 0,
                        explanation: "Each cat catches 1 mouse per 5 minutes. In 100 minutes, each cat catches 20 mice. So 5 cats catch 100 mice."
                    )
                ],
                difficulty: .hard
            ),
            
            // Science & Nature
            Quiz(
                title: "Science Fundamentals",
                description: "Test your science knowledge",
                category: .scienceNature,
                questions: [
                    QuizQuestion(
                        question: "What is the chemical symbol for gold?",
                        options: ["Go", "Au", "Gd", "Ag"],
                        correctAnswerIndex: 1,
                        explanation: "Au is the chemical symbol for gold, from the Latin word 'aurum'."
                    ),
                    QuizQuestion(
                        question: "How many planets are in our solar system?",
                        options: ["7", "8", "9", "10"],
                        correctAnswerIndex: 1,
                        explanation: "There are 8 planets in our solar system since Pluto was reclassified as a dwarf planet in 2006."
                    ),
                    QuizQuestion(
                        question: "What is the speed of light?",
                        options: ["299,792 km/s", "199,792 km/s", "399,792 km/s", "99,792 km/s"],
                        correctAnswerIndex: 0,
                        explanation: "The speed of light in a vacuum is approximately 299,792 kilometers per second."
                    ),
                    QuizQuestion(
                        question: "What is the largest organ in the human body?",
                        options: ["Heart", "Brain", "Liver", "Skin"],
                        correctAnswerIndex: 3,
                        explanation: "The skin is the largest organ of the human body, covering about 2 square meters."
                    ),
                    QuizQuestion(
                        question: "What gas do plants absorb from the atmosphere?",
                        options: ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"],
                        correctAnswerIndex: 2,
                        explanation: "Plants absorb carbon dioxide during photosynthesis and release oxygen."
                    )
                ],
                difficulty: .easy
            ),
            
            // History
            Quiz(
                title: "World History",
                description: "Journey through time",
                category: .history,
                questions: [
                    QuizQuestion(
                        question: "In which year did World War II end?",
                        options: ["1943", "1944", "1945", "1946"],
                        correctAnswerIndex: 2,
                        explanation: "World War II ended in 1945 with the surrender of Japan in September."
                    ),
                    QuizQuestion(
                        question: "Who was the first President of the United States?",
                        options: ["Thomas Jefferson", "George Washington", "John Adams", "Benjamin Franklin"],
                        correctAnswerIndex: 1,
                        explanation: "George Washington served as the first President of the United States from 1789 to 1797."
                    ),
                    QuizQuestion(
                        question: "What year did the Berlin Wall fall?",
                        options: ["1987", "1988", "1989", "1990"],
                        correctAnswerIndex: 2,
                        explanation: "The Berlin Wall fell on November 9, 1989, marking the beginning of German reunification."
                    ),
                    QuizQuestion(
                        question: "Which ancient wonder is still standing?",
                        options: ["Hanging Gardens of Babylon", "Great Pyramid of Giza", "Colossus of Rhodes", "Lighthouse of Alexandria"],
                        correctAnswerIndex: 1,
                        explanation: "The Great Pyramid of Giza is the only ancient wonder of the world still standing today."
                    ),
                    QuizQuestion(
                        question: "Who invented the telephone?",
                        options: ["Thomas Edison", "Nikola Tesla", "Alexander Graham Bell", "Guglielmo Marconi"],
                        correctAnswerIndex: 2,
                        explanation: "Alexander Graham Bell is credited with inventing the telephone in 1876."
                    )
                ],
                difficulty: .medium
            ),
            
            // Sports
            Quiz(
                title: "Sports Trivia",
                description: "Test your sports knowledge",
                category: .sports,
                questions: [
                    QuizQuestion(
                        question: "How many players are on a basketball team on the court?",
                        options: ["4", "5", "6", "7"],
                        correctAnswerIndex: 1,
                        explanation: "A basketball team has 5 players on the court at any given time."
                    ),
                    QuizQuestion(
                        question: "In which sport would you perform a 'slam dunk'?",
                        options: ["Volleyball", "Basketball", "Tennis", "Football"],
                        correctAnswerIndex: 1,
                        explanation: "A slam dunk is a basketball shot where a player jumps and forcefully puts the ball through the hoop."
                    ),
                    QuizQuestion(
                        question: "How many Grand Slam tournaments are there in tennis?",
                        options: ["3", "4", "5", "6"],
                        correctAnswerIndex: 1,
                        explanation: "There are 4 Grand Slam tournaments: Australian Open, French Open, Wimbledon, and US Open."
                    ),
                    QuizQuestion(
                        question: "What is the maximum score in a single frame of bowling?",
                        options: ["100", "200", "300", "30"],
                        correctAnswerIndex: 3,
                        explanation: "The maximum score in a single frame is 30 (strike followed by two more strikes)."
                    ),
                    QuizQuestion(
                        question: "How long is an Olympic swimming pool?",
                        options: ["25 meters", "50 meters", "75 meters", "100 meters"],
                        correctAnswerIndex: 1,
                        explanation: "An Olympic-size swimming pool is 50 meters long."
                    )
                ],
                difficulty: .easy
            )
        ]
    }
    
    // MARK: - Results Management
    func saveResult(_ result: QuizResult) {
        var results = getResults()
        results.append(result)
        
        if let encoded = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(encoded, forKey: resultsKey)
        }
        
        updateStats(with: result)
    }
    
    func getResults() -> [QuizResult] {
        guard let data = UserDefaults.standard.data(forKey: resultsKey),
              let results = try? JSONDecoder().decode([QuizResult].self, from: data) else {
            return []
        }
        return results.sorted { $0.date > $1.date }
    }
    
    func deleteAllResults() {
        UserDefaults.standard.removeObject(forKey: resultsKey)
        UserDefaults.standard.removeObject(forKey: statsKey)
    }
    
    // MARK: - Stats Management
    private func updateStats(with result: QuizResult) {
        var stats = getStats()
        
        stats.totalQuizzesTaken += 1
        stats.totalQuestionsAnswered += result.totalQuestions
        stats.totalCorrectAnswers += result.score
        
        let results = getResults()
        let totalScore = results.reduce(0.0) { $0 + $1.percentage }
        stats.averageScore = totalScore / Double(results.count)
        
        // Determine favorite category
        let categoryCount = Dictionary(grouping: results, by: { $0.category })
            .mapValues { $0.count }
        stats.favoriteCategory = categoryCount.max(by: { $0.value < $1.value })?.key
        
        if let encoded = try? JSONEncoder().encode(stats) {
            UserDefaults.standard.set(encoded, forKey: statsKey)
        }
    }
    
    func getStats() -> UserStats {
        guard let data = UserDefaults.standard.data(forKey: statsKey),
              let stats = try? JSONDecoder().decode(UserStats.self, from: data) else {
            return UserStats()
        }
        return stats
    }
}

