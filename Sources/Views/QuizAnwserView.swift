//
//  QuizAnwserView.swift
//

import UIKit

class QuizAnwserView: UIView {
    
    struct Settings {
        var anwserText: String?
        var isCorrectAnwser = false
    }

    var settings = Settings() {
        didSet {
            updateSettings()
        }
    }

    var didTapCorrectAnwser: BoolClosureVoid?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var anwserLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var mainButtonView: ButtonView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        anwserLabel.textColor = .black
        imageView.isHidden = true

        mainButtonView.didTap = { [ weak self] in
            guard let self else { return }

            anwserLabel.textColor = .black
            stackView.backgroundColor = settings.isCorrectAnwser ? .green : .red
            imageView.image = settings.isCorrectAnwser ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "x.circle")
            imageView.isHidden = false

            if settings.isCorrectAnwser {
                Feedback.generate(.success)
                didTapCorrectAnwser?(true)
            } else {
                didTapCorrectAnwser?(false)
                Feedback.generate(.error)
            }
        }

        prepareForReuse()
    }

    private func updateSettings() {
        anwserLabel.text = settings.anwserText
    }

    func prepareForReuse() {
        settings = .init()
    }
}
