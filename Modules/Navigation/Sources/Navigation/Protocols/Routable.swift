//
//  Routable.swift
//
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit

public typealias Routable = Coordinator & Root

public protocol Root: Presentable {

    func setRoot(_ controller: UIViewController, animated: Bool)
    func present(_ controller: UIViewController)
    func dismiss(_ animated: Bool)
}
