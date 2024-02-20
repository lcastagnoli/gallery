//
//  Presentable.swift
//  
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit

public protocol Presentable: AnyObject {

    var root: UIViewController { get }
}

extension UINavigationController: Presentable {

    public var root: UIViewController { self }
}

