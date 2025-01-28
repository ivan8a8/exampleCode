//
//  QuizCardView.swift
//

import UIKit

class QuizCardView: UIView {

    struct Settings {
        var points: Int?
    }

    var settings = Settings() {
        didSet {
            updateSettings()
        }
    }

    var didTap: EmptyVoid?

    @IBOutlet weak var quizResultView: UIView!
    @IBOutlet weak var quizResultLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        bottomButton.setTitle(Localization.quizCardButtonTitle, for: .normal)

        prepareForReuse()
    }

    private func updateSettings() {
        quizResultLabel.text = "\(settings.points ?? 0)/\(Context.resultsManager.totalQuizQuestions)"
        subtitleLabel.text = Localization.quizCardScoreText("\(settings.points ?? 0)")

        switch settings.points ?? 0 {
        case 0...4:
            quizResultView.backgroundColor = .black
            titleLabel.text = Localization.quizCardFinishedBad
            subtitleLabel.textColor = .red
        case 5...7:
            quizResultView.backgroundColor = .black
            titleLabel.text = Localization.quizCardFinishedOk
            subtitleLabel.textColor = .black
        case 8...9:
            quizResultView.backgroundColor = .black
            titleLabel.text = Localization.quizCardFinishedGreat
            subtitleLabel.textColor = .green
        case 10:
            quizResultView.backgroundColor = .black
            titleLabel.text = Localization.quizCardFinishedTop
            subtitleLabel.textColor = .green

        default: break
        }
    }

    func prepareForReuse() {
        settings = .init()
    }

    @IBAction func bottomButtonPressed() {
        didTap?()
    }
}
