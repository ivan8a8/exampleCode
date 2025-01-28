//
//  QuizQuestionView.swift
//

import UIKit

class QuizQuestionView: UIView {

    struct Settings {
        var questionText: String?
        var numberText: String?
    }

    var settings = Settings() {
        didSet {
            updateSettings()
        }
    }

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        prepareForReuse()
    }

    private func updateSettings() {
        numberLabel.text = settings.numberText
        questionLabel.text = settings.questionText
    }

    func prepareForReuse() {
        settings = .init()
    }
}
