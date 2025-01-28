//
//  Message.swift
//

import UIKit

class Message {

    static func showAlert(title: String? = nil, message: String?, image: UIImage? = nil, sender: UIViewController? = nil, didTap: EmptyVoid? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(.init(title: Localization.alertOk, style: .cancel) { _ in
            didTap?()
        })
        sender?.present(alertVC, animated: true)
    }
}
