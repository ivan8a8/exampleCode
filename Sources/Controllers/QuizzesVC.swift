//
//  QuizzesVC.swift
//

import UIKit

class QuizzesVC: BaseVC {

    override class var storyboardIfNeeded: UIStoryboard? { .quizzes }
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var scrollView = UIScrollView()
    private var stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        headerTitleLabel.text = Localization.quizzesTitle

        let stackedScrollView = stackedScrollView(insets: .init(vertical: 20), pinTop: headerView)
        scrollView = stackedScrollView.scrollView
        stackView = stackedScrollView.stackView
        stackView.spacing = 24

        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentedControl.setTitle(Localization.quizzesCurrent, forSegmentAt: 0)
        segmentedControl.setTitle(Localization.quizzesDone, forSegmentAt: 1)
        segmentedControl.layer.cornerRadius = 12
        segmentedControl.layer.masksToBounds = true
        segmentedControl.clipsToBounds = true

        addItems()

        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func addItems(onlyFinished: Bool = false) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en")

        calendar.standaloneMonthSymbols.enumerated().forEach { index, monthName in

            let date = Date()
            let components = calendar.dateComponents([.month], from: date)
            let month = components.month

            let challengeName = Localization.quizzesActiveItemText(monthName)
            let testYourselfName = Localization.quizzesInactiveItemText("\(index + 1)")

            let quizzes: CustomItem = .xibView()
            quizzes.didTapBottomButton = { [weak self] in
                guard let self else { return }
                QuizVC.controller().open(sender: self)
            }
            quizzes.didTap = { [weak self] in
                guard let self else { return }

                if month == (index + 1) {
                    QuizVC.controller().open(sender: self)
                } else {
                    Message.showAlert(message: Localization.quizzesItemLocked, sender: self)
                }
            }

            quizzes.settings = .init(
                titleText: month == (index + 1) ? testYourselfName : challengeName,
                titleTextFont: .systemFont(ofSize: 14, weight: .regular),
                titleTextColor: .black,
                subtitleText: month == (index + 1) ? challengeName : testYourselfName,
                subtitleTextFont: .systemFont(ofSize: 24, weight: .bold),
                subtitleTextColor: .black,
                leftView: .init(
                    image: month == (index + 1) ? UIImage(systemName: "checkmark") : UIImage(systemName: "xmark"),
                    backgroundColor: month == (index + 1) ? .white : .clear
                ),
                backgroundColor: ((index % 2) != 0) ? .gray.withAlphaComponent(0.5) : .black.withAlphaComponent(0.5),
                showHeader: false,
                isTappableFullView: true,
                bottomButton: month == (index + 1) ? .init(
                    text: Context.resultsManager.finishedQuizWithPoint(month: index + 1) ? Localization.quizzesItemPlayAgain : Localization.quizzesItemPlay,
                    textColor: .white,
                    textFont: .systemFont(ofSize: 18, weight: .bold),
                    backgroundColor: .black
                ) : nil,
                titlePadding: .init(top: month == (index + 1) ? 5 : 20),
                subtitlePadding: month == (index + 1) ? .init(bottom: 10) : .init(all: .zero),
                padding: month == (index + 1) ? .init(all: 20) : .init(top: 20, leading: 20, bottom: 53, trailing: 20)
            )

            if onlyFinished == true && Context.resultsManager.finishedQuizWithPoint(month: index + 1) == true {
                stackView.addArrangedSubview(quizzes)
            } else if onlyFinished == false {
                stackView.addArrangedSubview(quizzes)
            }
        }
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            addItems()
        } else {
            addItems(onlyFinished: true)
        }
    }
}

extension QuizzesVC: UIGestureRecognizerDelegate {}
