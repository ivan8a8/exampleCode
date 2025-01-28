//
//  UIViewExtension.swift
//

import UIKit

extension UIView {

    @discardableResult
    func pinAll(to view: UIView, usingSafeArea: Bool = false, insets: NSDirectionalEdgeInsets = .zero) -> (top: NSLayoutConstraint, leading: NSLayoutConstraint, bottom: NSLayoutConstraint, trailing: NSLayoutConstraint) {
        let horizontal = pinHorizontal(to: view, usingSafeArea: usingSafeArea, insetleading: insets.leading, insetTrailing: insets.trailing)
        let vertical = pinVertical(to: view, usingSafeArea: usingSafeArea, insetTop: insets.top, insetBottom: insets.bottom)
        return (vertical.top, horizontal.leading, vertical.bottom, horizontal.trailing)
    }

    @discardableResult
    func pinLeading(to view: UIView, usingSafeArea: Bool = false, inset: CGFloat = .zero) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: usingSafeArea ? view.layoutMarginsGuide.leadingAnchor : view.leadingAnchor, constant: inset)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinTrailing(to view: UIView, usingSafeArea: Bool = false, inset: CGFloat = .zero) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(equalTo: usingSafeArea ? view.layoutMarginsGuide.trailingAnchor : view.trailingAnchor, constant: -inset)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinTop(to view: UIView, usingSafeArea: Bool = false, inset: CGFloat = .zero) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: usingSafeArea ? view.layoutMarginsGuide.topAnchor : view.topAnchor, constant: inset)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinBottom(to view: UIView, usingSafeArea: Bool = false, inset: CGFloat = .zero) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: usingSafeArea ? view.layoutMarginsGuide.bottomAnchor : view.bottomAnchor, constant: -inset)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinHorizontal(to view: UIView, usingSafeArea: Bool = false, insetleading: CGFloat = .zero, insetTrailing: CGFloat = .zero) -> (leading: NSLayoutConstraint, trailing: NSLayoutConstraint) {
        (
            pinLeading(to: view, usingSafeArea: usingSafeArea, inset: insetleading),
            pinTrailing(to: view, usingSafeArea: usingSafeArea, inset: insetTrailing)
        )
    }

    @discardableResult
    func pinVertical(to view: UIView, usingSafeArea: Bool = false, insetTop: CGFloat = .zero, insetBottom: CGFloat = .zero) -> (top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
        (
            pinTop(to: view, usingSafeArea: usingSafeArea, inset: insetTop),
            pinBottom(to: view, usingSafeArea: usingSafeArea, inset: insetBottom)
        )
    }

    class func xibView<T: UIView>() -> T {
        let view = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
