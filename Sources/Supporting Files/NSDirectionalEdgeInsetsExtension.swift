//
//  NSDirectionalEdgeInsetsExtension.swift
//

import UIKit

extension NSDirectionalEdgeInsets {

    init(all: CGFloat) {
        self.init(top: all, leading: all, bottom: all, trailing: all)
    }

    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    init(vertical: CGFloat) {
        self.init(top: vertical, leading: .zero, bottom: vertical, trailing: .zero)
    }

    init(horizontal: CGFloat) {
        self.init(top: .zero, leading: horizontal, bottom: .zero, trailing: horizontal)
    }

    init(leading: CGFloat) {
        self.init(top: .zero, leading: leading, bottom: .zero, trailing: .zero)
    }

    init(trailing: CGFloat) {
        self.init(top: .zero, leading: .zero, bottom: .zero, trailing: trailing)
    }

    init(top: CGFloat) {
        self.init(top: top, leading: .zero, bottom: .zero, trailing: .zero)
    }

    init(bottom: CGFloat) {
        self.init(top: .zero, leading: .zero, bottom: bottom, trailing: .zero)
    }
}
