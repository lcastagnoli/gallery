//
//  DataSheetView.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 28/02/24.
//

import UIKit
import UI

final class DataSheetView: UIView {

    // MARK: IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    // MARK: Properties
    private weak var delegate: HeaderViewDelegate?

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        loadNib()
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        loadNib()
        setupView()
    }

    // MARK: Methods
    private func setupView() {

        backgroundColor = .blackGrey
        titleLabel.style(as: .title)
        contentLabel.style(as: .content)
        titleLabel.numberOfLines = .zero
        contentLabel.numberOfLines = .zero
    }

    func setup(with viewModel: DataSheetViewModel) {

        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.description.unwrapped
    }
}

// MARK: NibLoadable
extension DataSheetView: NibLoadable {}
