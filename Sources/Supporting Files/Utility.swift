//
//  Utility.swift
//

import UIKit

struct Utility {

    struct ResponseQuiz: Decodable {
        let question: String
        let anwsers: [String]
        let correctAnswer: String
    }

    static var quiz: [ResponseQuiz] {
        guard let url = Bundle.main.url(forResource: "Quiz.json", withExtension: nil), let json = try? String(contentsOf: url), let data = json.data(using: .utf8) else {
            assertionFailure()
            return []
        }

        guard let value = JSONDecoder.decode(type: [ResponseQuiz].self, from: data) else {
            assertionFailure()
            return []
        }

        return value
    }
}
