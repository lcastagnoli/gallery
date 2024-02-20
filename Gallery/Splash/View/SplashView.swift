//
//  SplashView.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit

final class SplashView: UIView {
    
    // MARK: Properties
    private var backgroundImage = UIImageView()
    private var loader = UIActivityIndicatorView(style: .medium)
    private var imageNamed: String
    
    // MARK: Initializers
    init(imageNamed: String) {

        self.imageNamed = imageNamed
        super.init(frame: .zero)

        self.configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods
    private func configureView() {
        
        backgroundImage.image = UIImage(named: imageNamed)
        addSubview(backgroundImage)
        backgroundImage.constraintsEqualToSuperview()
        addSubview(loader)
        loader.constraintsAlignedCenterInSuperview()
    }
    
    public func startLoading() {
        loader.startAnimating()
    }
    
    public func stopLoading() {
        loader.stopAnimating()
    }
}
