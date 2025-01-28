//
//  QuizVC.swift
//

import UIKit

class QuizVC: BaseVC {

    override class var storyboardIfNeeded: UIStoryboard? { .quiz }

    @IBOutlet weak var backButtonView: ButtonView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!

    private var scrollView = UIScrollView()
    private var stackView = UIStackView()
    private var count = 0
    private let quizData = Utility.quiz.shuffled().prefix(10)
    private var isFirstTapAnwser = true
    private var points = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerTitleLabel.text = Localization.quizTitle

        let stackedScrollView = stackedScrollView(insets: .init(vertical: 20), pinTop: headerView)
        scrollView = stackedScrollView.scrollView
        stackView = stackedScrollView.stackView
        stackView.spacing = 20

        backButtonView.didTap = { [weak self] in
            guard let self else { return }
            navigationController?.popViewController(animated: true)
        }

        addQuestionWithAnwsersViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func addQuestionWithAnwsersViews() {

        if (quizData.count - 1) >= count {
            stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            let quizItem = quizData[count]
            let anwsers = quizItem.anwsers.shuffled()

            let questionView: QuizQuestionView = .xibView()
            questionView.settings = .init(
                questionText: quizItem.question,
                numberText: "\(count + 1)/\(quizData.count)"
            )

            stackView.addArrangedSubview(questionView)

            let spacer = UIView(frame: .init(x: .zero, y: .zero, width: stackView.frame.width, height: 27))
            spacer.backgroundColor = .clear
            stackView.addArrangedSubview(spacer)

            anwsers.forEach { anwser in
                let anwserView: QuizAnwserView = .xibView()
                anwserView.settings = .init(
                    anwserText: anwser,
                    isCorrectAnwser: anwser == quizItem.correctAnswer
                )

                anwserView.didTapCorrectAnwser = { [weak self] correctAnwser in
                    guard let self else { return }
                    if correctAnwser {
                        count += 1
                        points += isFirstTapAnwser ? 1 : 0

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                            self?.isFirstTapAnwser = true
                            self?.addQuestionWithAnwsersViews()
                        }
                    } else {
                        isFirstTapAnwser = false
                    }
                }

                stackView.addArrangedSubview(anwserView)
            }
        } else {
            Context.resultsManager.addQuiz(correctAnwsers: points, date: Date())

            let quizCardView: QuizCardView = .xibView()
            quizCardView.didTap = { [weak self] in
                guard let self else { return }
                view.subviews.forEach { ($0 as? QuizCardView)?.removeFromSuperview() }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            }
            quizCardView.settings = .init(
                points: points
            )

            view.addSubview(quizCardView)
            quizCardView.pinAll(to: view)
        }
    }

    func open(sender: UIViewController) {
        hidesBottomBarWhenPushed = true
        sender.navigationController?.pushViewController(self, animated: true)
    }
}
