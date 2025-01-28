//
//  CustomItem.swift
//

import UIKit

class CustomItem: UIView {

    struct Settings {
        struct BottomButton {
            var text: String?
            var textColor = UIColor.white
            var textFont = UIFont.systemFont(ofSize: 15, weight: .bold)
            var backgroundColor = UIColor.black
        }

        struct LeftView {
            var image: UIImage?
            var backgroundColor = UIColor.white
        }

        var headerText: String?
        var titleText: String?
        var titleTextFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        var titleTextColor = UIColor.black
        var subtitleText: String?
        var subtitleTextFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        var subtitleTextColor = UIColor.black
        var moreText: String?
        var emojiText: String?
        var rightImage: UIImage?
        var leftView: LeftView?
        var backgroundColor = UIColor.darkGray
        var showHeader = true
        var isTappableFullView = false
        var bottomButton: BottomButton?
        var titlePadding = NSDirectionalEdgeInsets(all: .zero)
        var subtitlePadding = NSDirectionalEdgeInsets(all: .zero)
        var padding = NSDirectionalEdgeInsets(all: 20)
    }

    var settings = Settings() {
        didSet {
            updateSettings()
        }
    }

    var didTap: EmptyVoid?
    var didTapMore: EmptyVoid?
    var didTapRightImage: EmptyVoid?
    var didTapBottomButton: EmptyVoid?

    @IBOutlet weak var moreButtonView: ButtonView!
    @IBOutlet weak var moreLabel: UILabel!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var itemStackView: UIStackView!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var rightImageButtonView: ButtonView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var bottomButtonView: ButtonView!
    @IBOutlet weak var bottomButtonLabel: UILabel!
    @IBOutlet weak var emojiStackView: UIStackView!
    @IBOutlet weak var itemButonView: ButtonView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var subtitleStackView: UIStackView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var leftView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        moreButtonView.didTap = { [weak self] in
            self?.didTapMore?()
        }

        rightImageButtonView.didTap = { [weak self] in
            self?.didTapRightImage?()
        }

        bottomButtonView.didTap = { [weak self] in
            self?.didTapBottomButton?()
        }

        prepareForReuse()
    }

    private func updateSettings() {
        moreLabel.text = settings.moreText
        headerTitleLabel.text = settings.headerText
        titleLabel.text = settings.titleText
        titleLabel.font = settings.titleTextFont
        titleLabel.textColor = settings.titleTextColor
        subtitleLabel.text = settings.subtitleText
        subtitleLabel.font = settings.subtitleTextFont
        subtitleLabel.textColor = settings.subtitleTextColor
        emojiLabel.text = settings.emojiText == nil ? " " : settings.emojiText
        emojiLabel.font = .systemFont(ofSize: settings.emojiText == nil ? .zero : 40)
        rightImageView.image = settings.rightImage
        leftImageView.image = settings.leftView?.image
        leftView.backgroundColor = settings.leftView?.backgroundColor
        itemStackView.backgroundColor = settings.backgroundColor
        headerStackView.isHidden = !settings.showHeader
        itemStackView.directionalLayoutMargins = settings.padding
        titleStackView.directionalLayoutMargins = settings.titlePadding
        subtitleStackView.directionalLayoutMargins = settings.subtitlePadding

        bottomButtonView.backgroundColor = settings.bottomButton?.backgroundColor
        bottomButtonLabel.text = settings.bottomButton?.text
        bottomButtonLabel.textColor = settings.bottomButton?.textColor
        bottomButtonLabel.font = settings.bottomButton?.textFont


        leftView.isHidden = settings.leftView == nil
        bottomButtonView.isHidden = settings.bottomButton == nil
        titleLabel.isHidden = settings.titleText == nil
        subtitleLabel.isHidden = settings.subtitleText == nil
        rightImageButtonView.isHidden = settings.rightImage == nil
        emojiStackView.isHidden = settings.emojiText == nil && settings.rightImage == nil && settings.leftView == nil

        if settings.isTappableFullView {
            itemButonView.didTap = { [weak self] in
                self?.didTap?()

            }
        }
    }

    func prepareForReuse() {
        settings = .init()
    }
}
