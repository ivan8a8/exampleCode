//
//  BaseVC.swift
//

import UIKit

typealias EmptyVoid = () -> Void
typealias BoolClosureVoid = (Bool) -> Void

class BaseVC: UIViewController {
    @objc class var storyboardIfNeeded: UIStoryboard? { nil }

    static func controllerFromStoryboard<T: UIViewController>() -> T {
        guard let storyboard = storyboardIfNeeded else {
            fatalError("Storyboard not set")
        }

        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
    }

    static func controller() -> Self {
        if storyboardIfNeeded != nil {
            controllerFromStoryboard()
        } else {
            Self()
        }
    }

    func stackedScrollView(insets: NSDirectionalEdgeInsets = .zero, pinTop: UIView? = nil) -> (stackView: UIStackView, scrollView: UIScrollView) {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)

        if let pinTop {
            scrollView.pinHorizontal(to: view)
            scrollView.pinBottom(to: view)
            scrollView.topAnchor.constraint(equalTo: pinTop.bottomAnchor).isActive = true
        } else {
            scrollView.pinAll(to: view)
        }

        let stackView = UIStackView()
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        stackView.pinAll(to: scrollView)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = insets

        return (stackView, scrollView)
    }
}
