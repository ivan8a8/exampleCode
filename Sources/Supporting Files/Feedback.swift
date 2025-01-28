//
//  Feedback.swift
//

import UIKit
import AudioToolbox

struct Feedback {
    enum FeedbackType {
        case select
        case success
        case warning
        case error
        case audioToolbox(UInt32)
    }

    static func generate(_ type: FeedbackType = .select) {
        switch type {
        case .select:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case let .audioToolbox(value):
            AudioServicesPlaySystemSoundWithCompletion(value, nil)
        }
    }
}
