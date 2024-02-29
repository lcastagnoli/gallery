//
//  SegmentView.swift
//
//
//  Created by Laryssa Castagnoli on 28/02/24.
//

import UIKit

public protocol SegmentViewDelegate: AnyObject {

    func didSelect(segment: SegmentView, index: Int)
}

public final class SegmentView: UIView {

    // MARK: Properties
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var widthConstraintLine: NSLayoutConstraint!
    @IBOutlet private weak var leadingConstraintLine: NSLayoutConstraint!
    @IBOutlet private weak var viewIndicator: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!

    private weak var delegate: SegmentViewDelegate?
    private var viewModels: [SegmentViewModel]?

    // MARK: Constants
    private enum Constants {
        static let spacing = 16.0
        static let leading = 20.0
        static let delayAnimation: CGFloat = 0.2
    }

    // MARK: Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }

    // MARK: Methods
    public func setup(with viewModels: [SegmentViewModel], delegate: SegmentViewDelegate?) {

        self.viewModels = viewModels
        self.delegate = delegate

        for index in .zero...viewModels.count - 1 {

            let viewModel = viewModels[index]
            createSegmentTab(index, viewModel.title)
        }
    }

    private func createSegmentTab(_ index: Int, _ title: String) {

        let tabButton = UIButton(as: .tab, title: title, tag: index)
        tabButton.addTarget(self, action: #selector(didSelect(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(tabButton)
    }

    @objc private func didSelect(_ button: UIButton) {

        didSelectTab(at: button.tag)
        delegate?.didSelect(segment: self, index: button.tag)
    }

    public func didSelectTab(at index: Int) {
        for case let tabButton as UIButton in stackView.arrangedSubviews {
            tabButton.isSelected = tabButton == stackView.arrangedSubviews[index]

            if tabButton.isSelected {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.changeIndicator(to: tabButton.frame)
                    self.layoutIfNeeded()
                }
            }
        }
    }

    private func changeIndicator(to frame: CGRect) {

        UIView.animate(withDuration: Constants.delayAnimation) {
            self.leadingConstraintLine.constant = frame.origin.x
            self.widthConstraintLine.constant = frame.size.width
        }
    }
}

// MARK: NibLoadable
extension SegmentView: NibLoadable {}
