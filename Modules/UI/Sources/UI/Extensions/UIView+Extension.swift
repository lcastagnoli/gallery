//
//  File.swift
//  
//
//  Created by Laryssa Castagnoli on 28/02/24.
//

import UIKit

extension UIView {

    func loadNib(bundle: Bundle = Bundle.module) {

        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.backgroundColor = .clear
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
