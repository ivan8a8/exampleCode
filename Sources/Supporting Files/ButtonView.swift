//
//  ButtonView.swift
//

import UIKit

class ButtonView: UIView {

    var didTap: EmptyVoid?

    override func awakeFromNib() {
        super.awakeFromNib()

        set()
    }

    init() {
        super.init(frame: .zero)

        set()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func set() {

        addTapGesture()
    }

    @objc func buttonPressed() {
        didTap?()
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonPressed))
        addGestureRecognizer(tapGesture)
        subviews.forEach {
            $0.isUserInteractionEnabled = true
        }
    }
}
